class Address < ApplicationRecord
  validates :street, :number, :neighborhood, :city, :state, :zip_code,
            :country, presence: true

  validate :validate_zip_code_with_api, if: :should_validate_zip_code?

  before_save :normalize_zip_code

  private

  def normalize_zip_code
    self.zip_code = zip_code.gsub(/[^0-9]/, '') if zip_code.present?
  end

  def validate_zip_code_with_api
    response = fetch_zip_code_data
    if response.code == 200
      zip_data = JSON.parse(response.body)

      if zip_data['city'] != city || zip_data['state'] != state
        errors.add(:zip_code, I18n.t('errors.messages.zip_code_mismatch'))
      end
    else
      errors.add(:zip_code, I18n.t('errors.messages.zip_code_unreachable'))
    end
  end

  def should_validate_zip_code?
    country == 'Brazil' && zip_code.present?
  end

  def fetch_zip_code_data
    RestClient.get("https://brasilapi.com.br/api/cep/v1/#{zip_code}")
  rescue RestClient::ExceptionWithResponse
    OpenStruct.new(code: 503)
  end
end

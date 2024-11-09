class User < ApplicationRecord
  validates :name, presence: true
  validates :registration_number, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP,
                              message: I18n.t('errors.messages.invalid_email') }

  validate :valid_cpf

  before_save :sanitize_registration_number

  private

  def valid_cpf
    return if registration_number.blank?

    unless cpf_valid?(registration_number)
      errors.add(:registration_number, I18n.t('errors.messages.invalid_cpf'))
    end
  end

  def cpf_valid?(cpf)
    cpf = cpf.gsub(/[^\d]/, '')
    return false if cpf.length != 11 || cpf.chars.uniq.size == 1

    digit1 = calculate_cpf_digit(cpf[0..8])
    digit2 = calculate_cpf_digit(cpf[0..9])
    cpf[-2..-1] == "#{digit1}#{digit2}"
  end

  def calculate_cpf_digit(digits)
    factor = digits.length + 1
    sum = digits.chars.map(&:to_i).each_with_index.sum do |digit, index|
      digit * (factor - index)
    end

    result = 11 - (sum % 11)
    result > 9 ? 0 : result
  end

  def sanitize_registration_number
    self.registration_number = registration_number.gsub(/\D/, '')
  end
end

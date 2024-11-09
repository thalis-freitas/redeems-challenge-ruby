class Redeem < ApplicationRecord
  belongs_to :user
  belongs_to :redeem_page
  belongs_to :address
  belongs_to :size_option, optional: true

  has_many :answers, dependent: :destroy

  enum :status, { pending: 0, approved: 1, rejected: 2 }

  validates :status, presence: true

  validate :size_option_required_if_redeem_page_has_size_options

  private

  def size_option_required_if_redeem_page_has_size_options
    return unless redeem_page&.size_options&.any? && size_option.nil?

    errors.add(:size_option, I18n.t('errors.messages.blank'))
  end
end

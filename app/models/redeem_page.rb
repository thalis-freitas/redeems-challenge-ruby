class RedeemPage < ApplicationRecord
  has_many :redeem_page_size_options
  has_many :size_options, through: :redeem_page_size_options

  validates :name, presence: true
  validates :active, inclusion: { in: [true, false] }
end

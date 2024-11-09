class RedeemPageSizeOption < ApplicationRecord
  belongs_to :redeem_page
  belongs_to :size_option

  validates :redeem_page_id, uniqueness: { scope: :size_option_id }
end

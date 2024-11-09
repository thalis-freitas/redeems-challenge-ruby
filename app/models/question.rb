class Question < ApplicationRecord
  belongs_to :redeem_page

  validates :content, presence: true
end

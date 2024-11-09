class Question < ApplicationRecord
  belongs_to :redeem_page
  has_many :answers, dependent: :destroy

  validates :content, presence: true
end

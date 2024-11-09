class Answer < ApplicationRecord
  belongs_to :redeem
  belongs_to :question

  validates :content, presence: true
end

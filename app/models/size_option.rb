class SizeOption < ApplicationRecord
  enum :size, { S: 0, M: 1, L: 2, XL: 3 }

  validates :size, presence: true
end

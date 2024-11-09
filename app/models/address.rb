class Address < ApplicationRecord
  validates :street, :number, :neighborhood, :city, :state, :zip_code,
            :country, presence: true
end

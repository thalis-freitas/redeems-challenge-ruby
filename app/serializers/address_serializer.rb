class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street, :number, :complement, :neighborhood, :city, :state,
             :zip_code, :country
end

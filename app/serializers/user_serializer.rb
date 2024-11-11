class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :registration_number, :email
end

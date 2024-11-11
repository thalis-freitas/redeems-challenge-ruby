class RedeemSerializer < ActiveModel::Serializer
  attributes :id, :status, :redeem_page_id

  has_one :user, serializer: UserSerializer
  has_one :address, serializer: AddressSerializer
end

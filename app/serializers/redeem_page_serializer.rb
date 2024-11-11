class RedeemPageSerializer < ActiveModel::Serializer
  attributes :id, :name, :active
  has_many :size_options, serializer: SizeOptionSerializer
  has_many :questions, serializer: QuestionSerializer
end

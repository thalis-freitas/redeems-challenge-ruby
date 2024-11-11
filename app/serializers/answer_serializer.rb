class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :content, :question_id

  belongs_to :question
end

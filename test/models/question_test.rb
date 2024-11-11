require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  describe '#valid?' do
    test 'content cannot be blank' do
      question = Question.new(content: '')

      question.valid?

      assert_includes question.errors.details[:content], { error: :blank }
      assert_includes question.errors[:content], I18n.t('errors.messages.blank')
    end
  end

  describe 'associations' do
    test 'belongs to redeem_page' do
      question = questions(:one)

      assert_equal redeem_pages(:active), question.redeem_page
    end

    test 'has many answers' do
      question = questions(:one)

      assert_equal 1, question.answers.count
      assert_instance_of Answer, question.answers.first
      assert_equal answers(:one), question.answers.first
    end

    test 'should destroy associated answers when question is destroyed' do
      question = questions(:one)
      answer = answers(:one)

      question.destroy

      assert_nil Answer.find_by(id: answer.id)
    end
  end
end

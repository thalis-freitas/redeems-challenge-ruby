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

      assert_equal redeem_pages(:one), question.redeem_page
    end
  end
end

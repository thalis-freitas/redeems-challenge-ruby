require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  describe '#valid?' do
    test 'content cannot be blank' do
      answer = Answer.new(content: '')

      answer.valid?

      assert_includes answer.errors.details[:content], { error: :blank }
      assert_includes answer.errors[:content], I18n.t('errors.messages.blank')
    end
  end

  describe 'associations' do
    test 'belongs to redeem' do
      answer = answers(:one)
      assert_equal redeems(:pending_redeem), answer.redeem
    end

    test 'belongs to question' do
      answer = answers(:one)
      assert_equal questions(:one), answer.question
    end
  end
end

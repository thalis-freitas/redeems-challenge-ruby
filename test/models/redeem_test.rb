require 'test_helper'

class RedeemTest < ActiveSupport::TestCase
  describe '#valid?' do
    test 'status cannot be blank' do
      redeem = Redeem.new(status: nil, user: users(:one),
                          redeem_page: redeem_pages(:active),
                          address: addresses(:one))

      redeem.valid?

      assert_includes redeem.errors.details[:status], { error: :blank }
      assert_includes redeem.errors[:status], I18n.t('errors.messages.blank')
    end

    test 'status accepts valid values' do
      %w[pending approved rejected].each do |valid_status|
        redeem = Redeem.new(status: valid_status, user: users(:two),
                            redeem_page: redeem_pages(:active_without_questions),
                            address: addresses(:one))

        assert redeem.valid?
      end
    end

    test 'status rejects invalid values' do
      invalid_status = 'invalid_status'

      assert_raises(ArgumentError, "'#{invalid_status}' is not a valid status") do
        Redeem.new(status: invalid_status)
      end
    end

    test 'size_option is required if redeem_page has size options' do
      redeem_page_with_sizes = redeem_pages(:inactive)
      redeem = Redeem.new(status: 'pending', user: users(:two),
                          redeem_page: redeem_page_with_sizes,
                          address: addresses(:one))

      redeem.valid?

      assert_includes redeem.errors[:size_option],
                      I18n.t('errors.messages.blank')
    end

    test 'size_option is not required if redeem_page has no size options' do
      redeem_page = redeem_pages(:active_without_questions)
      redeem = Redeem.new(status: 'pending', user: users(:two),
                          redeem_page: redeem_page,
                          address: addresses(:one))

      assert redeem.valid?
    end

    test 'should be invalid without answers for each question' do
      redeem = Redeem.new(redeem_page: redeem_pages(:active),
                          user: users(:two), address: addresses(:one))

      assert_not redeem.valid?
      assert_includes redeem.errors[:answers],
                      I18n.t('errors.messages.missing_answers')
    end

    test 'should be valid with answers for each question' do
      redeem_page = redeem_pages(:active)
      redeem = Redeem.new(redeem_page: redeem_page, user: users(:two),
                          address: addresses(:one))

      redeem_page.questions.each do |question|
        redeem.answers.build(content: "Answer #{question.content}",
                             question: question)
      end

      assert redeem.valid?
    end
  end

  describe 'associations' do
    test 'belongs to user' do
      redeem = redeems(:pending_redeem)
      assert_equal users(:one), redeem.user
    end

    test 'belongs to redeem_page' do
      redeem = redeems(:pending_redeem)
      assert_equal redeem_pages(:active), redeem.redeem_page
    end

    test 'belongs to address' do
      redeem = redeems(:pending_redeem)
      assert_equal addresses(:one), redeem.address
    end

    test 'belongs to size_option' do
      redeem = Redeem.new(status: 'approved', user: users(:one),
                          redeem_page: redeem_pages(:active),
                          address: addresses(:one),
                          size_option: size_options(:small))

      assert_equal size_options(:small), redeem.size_option
    end

    test 'is valid without a size_option' do
      redeem = Redeem.new(status: 'approved', user: users(:two),
                          redeem_page: redeem_pages(:active_without_questions),
                          address: addresses(:one))

      assert redeem.valid?
    end

    test 'has many answers' do
      redeem = redeems(:pending_redeem)

      assert_equal 2, redeem.answers.count
      assert_instance_of Answer, redeem.answers.first
      assert_includes redeem.answers, answers(:one)
      assert_includes redeem.answers, answers(:two)
    end
  end
end

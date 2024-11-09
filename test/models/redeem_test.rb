require 'test_helper'

class RedeemTest < ActiveSupport::TestCase
  describe '#valid?' do
    test 'status cannot be blank' do
      redeem = Redeem.new(status: nil, user: users(:one),
                          redeem_page: redeem_pages(:one),
                          address: addresses(:one))

      redeem.valid?

      assert_includes redeem.errors.details[:status], { error: :blank }
      assert_includes redeem.errors[:status], I18n.t('errors.messages.blank')
    end

    test 'status accepts valid values' do
      %w[pending approved rejected].each do |valid_status|
        redeem = Redeem.new(status: valid_status, user: users(:one),
                            redeem_page: redeem_pages(:one),
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
      redeem_page_with_sizes = redeem_pages(:two)
      redeem = Redeem.new(status: 'pending', user: users(:one),
                          redeem_page: redeem_page_with_sizes,
                          address: addresses(:one))

      redeem.valid?

      assert_includes redeem.errors[:size_option],
                      I18n.t('errors.messages.blank')
    end

    test 'size_option is not required if redeem_page has no size options' do
      redeem_page_without_sizes = redeem_pages(:one)
      redeem = Redeem.new(status: 'pending', user: users(:one),
                          redeem_page: redeem_page_without_sizes,
                          address: addresses(:one))

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
      assert_equal redeem_pages(:one), redeem.redeem_page
    end

    test 'belongs to address' do
      redeem = redeems(:pending_redeem)
      assert_equal addresses(:one), redeem.address
    end

    test 'belongs to size_option' do
      redeem = Redeem.new(status: 'approved', user: users(:one),
                          redeem_page: redeem_pages(:one),
                          address: addresses(:one),
                          size_option: size_options(:small))

      assert_equal size_options(:small), redeem.size_option
    end

    test 'is valid without a size_option' do
      redeem = Redeem.new(status: 'approved', user: users(:one),
                          redeem_page: redeem_pages(:one),
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

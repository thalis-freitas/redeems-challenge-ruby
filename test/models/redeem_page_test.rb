require 'test_helper'

class RedeemPageTest < ActiveSupport::TestCase
  describe '#valid?' do
    test 'name cannot be blank' do
      redeem_page = RedeemPage.new(name: '')

      redeem_page.valid?

      assert_includes redeem_page.errors.details[:name], { error: :blank }
      assert_includes redeem_page.errors[:name], I18n.t('errors.messages.blank')
    end

    test 'active must be true or false - invalid when nil' do
      redeem_page = RedeemPage.new(active: nil)

      redeem_page.valid?

      assert_includes redeem_page.errors.details[:active],
                      { error: :inclusion, value: nil }

      assert_includes redeem_page.errors[:active],
                      I18n.t('errors.messages.inclusion')
    end

    test 'active is valid when true or false' do
      redeem_page_true = RedeemPage.new(active: true)
      redeem_page_false = RedeemPage.new(active: false)

      assert_not_includes redeem_page_true.errors.details[:active],
                          { error: :inclusion, valid: nil }

      assert_not_includes redeem_page_false.errors.details[:active],
                          { error: :inclusion, valid: nil }
    end
  end

  describe 'associations' do
    test 'has many redeem_page_size_options' do
      redeem_page = redeem_pages(:one)

      assert_instance_of RedeemPageSizeOption,
                         redeem_page.redeem_page_size_options.first

      assert_equal 2, redeem_page.redeem_page_size_options.count
    end

    test 'has many size_options through redeem_page_size_options' do
      redeem_page = redeem_pages(:one)

      assert_instance_of SizeOption, redeem_page.size_options.first
      assert redeem_page.size_options.exists?(size: 'S')
      assert redeem_page.size_options.exists?(size: 'M')
    end
  end
end

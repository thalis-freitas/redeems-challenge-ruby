require 'test_helper'

class RedeemPageSizeOptionTest < ActiveSupport::TestCase
  describe '#valid?' do
    test 'is valid with unique redeem_page_id and size_option_id combination' do
      redeem_page_size_option = RedeemPageSizeOption.new(
        redeem_page: redeem_pages(:one), size_option: size_options(:extra_large)
      )

      assert redeem_page_size_option.valid?
    end

    test 'is invalid with duplicate redeem_page_id and size_option_id combination' do
      RedeemPageSizeOption.create!(
        redeem_page: redeem_pages(:one), size_option: size_options(:large)
      )

      duplicate_option = RedeemPageSizeOption.new(
        redeem_page: redeem_pages(:one), size_option: size_options(:large)
      )

      duplicate_option.valid?

      assert_includes duplicate_option.errors.details[:redeem_page_id],
                      { error: :taken, value: redeem_pages(:one).id }

      assert_includes duplicate_option.errors[:redeem_page_id],
                      I18n.t('errors.messages.taken')
    end
  end

  describe 'associations' do
    test 'belongs to redeem_page' do
      association = RedeemPageSizeOption.reflect_on_association(:redeem_page)
      assert_equal :belongs_to, association.macro
    end

    test 'belongs to size_option' do
      association = RedeemPageSizeOption.reflect_on_association(:size_option)
      assert_equal :belongs_to, association.macro
    end
  end
end

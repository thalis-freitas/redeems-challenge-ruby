require 'test_helper'

class RedeemPageTest < ActiveSupport::TestCase
  describe '#valid?' do
    test 'name cannot be blank' do
      redeem_page = RedeemPage.new(name: '')

      redeem_page.valid?

      assert_includes redeem_page.errors.details[:name], { error: :blank }
      assert_includes redeem_page.errors[:name], I18n.t('errors.messages.blank')
    end
  end
end

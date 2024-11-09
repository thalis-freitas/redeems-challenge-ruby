require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  describe '#valid?' do
    test 'street cannot be blank' do
      address = Address.new(street: '')

      address.valid?

      assert_includes address.errors.details[:street], { error: :blank }
      assert_includes address.errors[:street], I18n.t('errors.messages.blank')
    end

    test 'number cannot be blank' do
      address = Address.new(number: '')

      address.valid?

      assert_includes address.errors.details[:number], { error: :blank }
      assert_includes address.errors[:number], I18n.t('errors.messages.blank')
    end

    test 'neighborhood cannot be blank' do
      address = Address.new(neighborhood: '')

      address.valid?

      assert_includes address.errors.details[:neighborhood], { error: :blank }
      assert_includes address.errors[:neighborhood],
                      I18n.t('errors.messages.blank')
    end

    test 'city cannot be blank' do
      address = Address.new(city: '')

      address.valid?

      assert_includes address.errors.details[:city], { error: :blank }
      assert_includes address.errors[:city], I18n.t('errors.messages.blank')
    end

    test 'state cannot be blank' do
      address = Address.new(state: '')

      address.valid?

      assert_includes address.errors.details[:state], { error: :blank }
      assert_includes address.errors[:state], I18n.t('errors.messages.blank')
    end

    test 'zip_code cannot be blank' do
      address = Address.new(zip_code: '')

      address.valid?

      assert_includes address.errors.details[:zip_code], { error: :blank }
      assert_includes address.errors[:zip_code], I18n.t('errors.messages.blank')
    end

    test 'country cannot be blank' do
      address = Address.new(country: '')

      address.valid?

      assert_includes address.errors.details[:country], { error: :blank }
      assert_includes address.errors[:country], I18n.t('errors.messages.blank')
    end
  end
end

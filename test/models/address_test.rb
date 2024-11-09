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

    test 'zip_code must match city and state' do
      address = Address.new(city: 'Londrina', state: 'PR',
                            zip_code: '86035-560', country: 'Brazil')

      address.valid?

      assert_not_includes address.errors[:zip_code],
                          I18n.t('errors.messages.zip_code_mismatch')
    end

    test 'invalid zip_code does not match city/state' do
      address = Address.new(city: 'São Paulo', state: 'RJ',
                            zip_code: '60321070', country: 'Brazil')

      address.valid?

      assert_includes address.errors[:zip_code],
                      I18n.t('errors.messages.zip_code_mismatch')
    end

    test 'zip_code validation fails if API is unreachable' do
      address = Address.new(city: 'Santo André', state: 'SP',
                            zip_code: '09061-265', country: 'Brazil')

      Address.class_eval do
        alias_method :original_validate_zip_code_with_api,
                     :validate_zip_code_with_api

        define_method(:validate_zip_code_with_api) do
          errors.add(:zip_code, I18n.t('errors.messages.zip_code_unreachable'))
        end
      end

      address.valid?

      assert_includes address.errors[:zip_code],
                      I18n.t('errors.messages.zip_code_unreachable')

      Address.class_eval do
        alias_method :validate_zip_code_with_api,
                     :original_validate_zip_code_with_api
      end
    end
  end

  describe 'associations' do
    test 'has many redeems with dependent destroy' do
      address = addresses(:one)
      redeem = redeems(:pending_redeem)

      address.destroy

      assert_nil Redeem.find_by(id: redeem.id)
    end
  end
end

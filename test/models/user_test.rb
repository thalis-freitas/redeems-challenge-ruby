require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe '#valid?' do
    test 'name cannot be blank' do
      user = User.new(name: '')

      user.valid?

      assert_includes user.errors.details[:name], { error: :blank }
      assert_includes user.errors[:name], I18n.t('errors.messages.blank')
    end

    test 'registration_number cannot be blank' do
      user = User.new(registration_number: '')

      user.valid?

      assert_includes user.errors
                          .details[:registration_number], { error: :blank }

      assert_includes user.errors[:registration_number],
                      I18n.t('errors.messages.blank')
    end

    test 'registration_number must be unique' do
      existing_user = users(:one)
      user = User.new(registration_number: existing_user.registration_number)

      user.valid?

      assert_includes user.errors.details[:registration_number],
                      { error: :taken,
                        value: existing_user.registration_number }

      assert_includes user.errors[:registration_number],
                      I18n.t('errors.messages.taken')
    end

    test 'registration_number must be a valid CPF format' do
      invalid_cpfs = ['12345678900', '11111111111', '123.456.789-10']
      invalid_cpfs.each do |cpf|
        user = User.new(registration_number: cpf)

        user.valid?

        assert_includes user.errors[:registration_number],
                        I18n.t('errors.messages.invalid_cpf')
      end
    end

    test 'registration_number must be a valid CPF' do
      valid_cpf = '329.105.160-24'
      user = User.new(registration_number: valid_cpf)

      user.valid?

      refute_includes user.errors.details[:registration_number],
                      { error: I18n.t('errors.messages.invalid_cpf') }
    end

    test 'registration_number removes special characters before save' do
      user = User.new(name: 'Test User', registration_number: '329.105.160-24',
                      email: 'test@example.com')

      user.save!

      assert_equal '32910516024', user.registration_number
    end

    test 'email cannot be blank' do
      user = User.new(email: '')

      user.valid?

      assert_includes user.errors.details[:email], { error: :blank }
      assert_includes user.errors[:email], I18n.t('errors.messages.blank')
    end

    test 'email must be unique' do
      existing_user = users(:one)
      user = User.new(email: existing_user.email)

      user.valid?

      assert_includes user.errors.details[:email], { error: :taken,
                                                    value: existing_user.email }

      assert_includes user.errors[:email], I18n.t('errors.messages.taken')
    end

    test 'email must have a valid format' do
      user = User.new(email: 'invalid_email_format')

      user.valid?

      assert_includes user.errors[:email],
                      I18n.t('errors.messages.invalid_email')
    end
  end
end

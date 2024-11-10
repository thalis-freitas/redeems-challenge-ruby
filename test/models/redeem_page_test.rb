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
      redeem_page = redeem_pages(:inactive)

      assert_instance_of RedeemPageSizeOption,
                         redeem_page.redeem_page_size_options.first

      assert_equal 3, redeem_page.redeem_page_size_options.count
    end

    test 'has many size_options through redeem_page_size_options' do
      redeem_page = redeem_pages(:inactive)

      assert_instance_of SizeOption, redeem_page.size_options.first
      assert redeem_page.size_options.exists?(size: 'S')
      assert redeem_page.size_options.exists?(size: 'M')
    end

    test 'should destroy associated redeem_page_size_options when redeem_page is destroyed' do
      redeem_page = redeem_pages(:active)
      size_option = size_options(:large)

      redeem_page_size_option = RedeemPageSizeOption.create!(
        redeem_page: redeem_page, size_option: size_option
      )

      redeem_page.destroy

      assert_nil RedeemPageSizeOption.find_by(id: redeem_page_size_option.id)
    end

    test 'has many questions with dependent destroy' do
      redeem_page = redeem_pages(:active)
      question = Question.new(content: 'What is Lorem Ipsum?',
                              redeem_page: redeem_page)

      redeem_page.destroy

      assert_nil Question.find_by(id: question.id)
    end

    test 'redeem_page can exist without questions' do
      redeem_page = redeem_pages(:inactive)

      assert redeem_page.valid?
      assert_equal 0, redeem_page.questions.count
    end

    test 'has many redeems with dependent destroy' do
      redeem_page = redeem_pages(:active)
      redeem = Redeem.create!(status: 'pending', user: users(:one),
                              redeem_page: redeem_page, address: addresses(:one))

      redeem_page.destroy

      assert_nil Redeem.find_by(id: redeem.id)
    end
  end
end

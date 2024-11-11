require 'test_helper'

class RedeemPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @redeem_page = redeem_pages(:active)
    @size_option_small = size_options(:small)
    @size_option_large = size_options(:large)
    @redeem_page.size_options << [@size_option_small, @size_option_large]
  end

  describe 'GET /api/v1/redeem_pages/:id' do
    test 'should get redeem page data' do
      get api_v1_redeem_page_url(@redeem_page)
      assert_response :ok
    end

    describe 'with sized products' do
      test 'should get redeem page data with size options' do
        get api_v1_redeem_page_url(@redeem_page)

        response_data = response.parsed_body

        assert_response :ok
        assert_includes response_data.keys, 'size_options'
        assert_equal 2, response_data['size_options'].size
        assert_equal I18n.t(
          "activerecord.attributes.size_option.size.#{@size_option_small.size}"
        ), response_data['size_options'].first['size']
      end
    end

    describe 'with extra questions' do
      test 'should get redeem page data with questions' do
        get api_v1_redeem_page_url(@redeem_page)

        response_data = response.parsed_body

        assert_response :ok
        assert_includes response_data.keys, 'questions'
        assert_equal 2, response_data['questions'].size
        assert_equal 'What is your favorite color?',
                     response_data['questions'].first['content']
      end
    end

    describe 'inactive redeem page' do
      test 'should ommit redeem page data' do
        inactive_redeem_page = redeem_pages(:inactive)
        get api_v1_redeem_page_url(inactive_redeem_page)

        assert_response :forbidden
      end
    end

    describe 'non existent redeem page' do
      test 'should return not found' do
        get api_v1_redeem_page_url(id: 9999)

        assert_response :not_found
      end
    end
  end
end

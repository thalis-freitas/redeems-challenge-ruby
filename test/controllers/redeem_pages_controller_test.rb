# test/controllers/products_controller_test.rb
require 'test_helper'

class RedeemPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @redeem_page = RedeemPage.create
  end

  describe 'GET /api/v1/redeem_pages/:id' do
    test 'should get redeem page data' do
      get api_v1_redeem_page_url(@redeem_page)
      assert_response :ok
    end

    describe 'with sized products' do
      test 'should get redeem page data' do
        get api_v1_redeem_page_url(@redeem_page)
        assert_response :ok
      end
    end

    describe 'with extra questions' do
      test 'should get redeem page data' do
        get api_v1_redeem_page_url(@redeem_page)
        assert_response :ok
      end
    end

    describe 'inactive redeem page' do
      test 'should ommit redeem page data' do
        get api_v1_redeem_page_url(@redeem_page)
        assert_response :forbidden
      end
    end
  end
end

# test/controllers/products_controller_test.rb
require "test_helper"

class RedeemsControllerTest < ActionDispatch::IntegrationTest
  describe 'POST /api/v1/redeems' do
    test 'should create redeem associated with redeem page' do
      post api_v1_redeems_url
      assert_response :created
    end

    test 'returns created redeem data' do
      post api_v1_redeems_url
      assert_response :created
    end

    describe 'consecutive redeems' do
      test 'does not allow redeem creation' do
        post api_v1_redeems_url
        assert_response :unprocessable_entity
      end
    end
  end
end

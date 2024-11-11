require 'test_helper'

class RedeemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @redeem_page = redeem_pages(:active_without_questions)

    @redeem_page_with_questions = redeem_pages(:active)
    @redeem_page_with_questions.size_options << size_options(:small, :medium)

    @user_params = { name: 'Rebeca Rodrigues Sousa',
                     registration_number: '88463540015',
                     email: 'rebeca@email.com' }

    @address_params = { street: 'Rua Beija-Flor', number: '1246',
                        complement: 'Apt 4', neighborhood: 'Alvarenga',
                        city: 'São Bernardo do Campo', state: 'SP',
                        zip_code: '09856150', country: 'Brazil' }

    @redeem_params = { redeem_page_id: @redeem_page.id, user: @user_params,
                       address: @address_params }

    @answers_params = [{ content: 'Blue',
                         question_id: questions(:one).id },
                       { content: 'Internet',
                         question_id: questions(:two).id }]

    @redeem_params_with_questions = { redeem_page_id: @redeem_page_with_questions.id,
                                      user: @user_params,
                                      address: @address_params,
                                      size_option_id: size_options(:small).id,
                                      answers: @answers_params }
  end

  describe 'POST /api/v1/redeems' do
    test 'should create redeem associated with redeem page' do
      post api_v1_redeems_url, params: { redeem: @redeem_params }

      assert_response :created
    end

    test 'returns created redeem data' do
      post api_v1_redeems_url, params: { redeem: @redeem_params }

      response_data = response.parsed_body

      assert_response :created
      assert_equal @redeem_page.id, response_data['redeem_page_id']

      @user_params.each do |field, expected_value|
        assert_equal expected_value, response_data['user'][field.to_s]
      end

      @address_params.each do |field, expected_value|
        assert_equal expected_value, response_data['address'][field.to_s]
      end
    end

    describe 'consecutive redeems' do
      test 'does not allow redeem creation' do
        post api_v1_redeems_url, params: { redeem: @redeem_params }
        post api_v1_redeems_url, params: { redeem: @redeem_params }

        assert_response :unprocessable_entity
        response_data = response.parsed_body
        assert_includes response_data['errors'],
                        I18n.t('errors.messages.consecutive_redeems_not_allowed')
      end
    end

    describe 'with questions and size options' do
      test 'should create redeem with size option and answers for questions' do
        post api_v1_redeems_url,
             params: { redeem: @redeem_params_with_questions }

        response_data = response.parsed_body

        assert_response :created

        assert_equal @redeem_page_with_questions.id,
                     response_data['redeem_page_id']

        assert_equal size_options(:small).id, response_data['size_option']['id']

        @answers_params.each_with_index do |answer, index|
          assert_equal answer[:content],
                       response_data['answers'][index]['content']

          assert_equal answer[:question_id],
                       response_data['answers'][index]['question_id']
        end
      end
    end

    test 'should ignore size option if redeem page has no size options' do
      post api_v1_redeems_url, params: { redeem: @redeem_params }

      assert_response :created
      assert_nil Redeem.last.size_option_id
    end
  end
end

class Api::V1::RedeemsController < ApiController
  def create
    redeem = Redeem.create_with_user_and_address(redeem_params, user_params,
                                                 address_params)

    render json: redeem, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages },
           status: :unprocessable_entity
  end

  private

  def redeem_params
    params.require(:redeem).permit(:redeem_page_id)
  end

  def user_params
    params.require(:redeem)
          .require(:user)
          .permit(:name, :registration_number, :email)
  end

  def address_params
    params.require(:redeem)
          .require(:address)
          .permit(:street, :number, :complement, :neighborhood, :city, :state,
                  :zip_code, :country)
  end
end

class Api::V1::RedeemPagesController < ApiController
  def show
    @redeem_page = RedeemPage.find(params[:id])

    return render json: @redeem_page, status: :ok if @redeem_page.active

    head :forbidden
  end
end

class TradesController < ApplicationController
  def index
    @wallet = Wallet.find_by(url: params[:url])
    @trade_message = TradeMessage.new
  end

  def create
    @wallet = Wallet.find_by(url: params[:url])
    @wallet_user = @wallet.user_id
    @trade_message = TradeMessage.new(trade_params)

    if @trade_message.valid?
      @trade_message.save
      @wallet.update(plus: @wallet.plus.to_i + trade_params[:quantity].to_i)
      total_price =
        trade_params[:quantity].to_i * trade_params[:unit_price].to_i

      payment_intent =
        Stripe::PaymentIntent.create(
          {
            amount: total_price,
            currency: "jpy",
            customer: current_user.customer_id,
            transfer_data: {
              amount: (total_price * 0.95 - total_price * 0.036).to_i,
              destination: User.find(@wallet_user).uid
            }
          }
        )
      Stripe::PaymentIntent.confirm(
        payment_intent.id,
        { payment_method: "pm_card_visa" }
      )
      redirect_to wallet_path(url: params[:url])
    else
      render :new
    end
  end

  private

  def trade_params
    params
      .require(:trade_message)
      .permit(:message, :unit_price, :quantity)
      .merge(
        user_id: current_user.id,
        pay_u_id: current_user.id,
        beneficiary_u_id: @wallet_user
      )
  end
end

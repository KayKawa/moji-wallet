class TradesController < ApplicationController
  def index
    @wallet = Wallet.find_by(url: params[:id])
    @trade_message = TradeMessage.new
  end

  def create
    @wallet = Wallet.find_by(url: params[:url])
    @wallet_user = @wallet.user_id
    @trade_message = TradeMessage.new(trade_params)

    if @trade_message.valid?
      @trade_message.save
      @wallet.update(plus: @wallet.plus.to_i + trade_params[:quantity].to_i)
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

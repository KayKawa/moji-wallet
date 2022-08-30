class TransactionsController < ApplicationController
  def index
    @wallet = Wallet.find_by(url: params[:id])
    @transaction = Transaction.new
  end

  def create
    @wallet = Wallet.find_by(url: params[:url])
    @wallet_user = @wallet.user_id
    Transaction.create(transaction_params)
    @wallet.update(plus: @wallet.plus.to_i + transaction_params[:quantity].to_i)
    redirect_to wallet_path(url: params[:url])
  end

  private

  def transaction_params
    params
      .require(:transaction)
      .permit(:unit_price, :quantity)
      .merge(pay_u_id: current_user.id, beneficiary_u_id: @wallet_user)
  end
end

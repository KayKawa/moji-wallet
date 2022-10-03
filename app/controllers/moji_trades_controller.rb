class MojiTradesController < ApplicationController
  def index
    @wallet = Wallet.find_by(url: params[:url])
    @trade_message = TradeMessage.new
  end

  def create
    @wallet = Wallet.find_by(url: params[:url])
    @wallet_user = @wallet.user_id
    @trade_message = TradeMessage.new(trade_params)
    total_price = trade_params[:quantity].to_i * trade_params[:unit_price].to_i

    if @trade_message.valid?
      @trade_message.save
      @wallet.update(plus: @wallet.plus.to_i + trade_params[:quantity].to_i)

      product = Stripe::Product.create({ name: "#{@wallet.url}さんへMOJIを贈る" })
      price =
        Stripe::Price.create(
          { product: product.id, unit_amount: total_price, currency: "jpy" }
        )

      session =
        Stripe::Checkout::Session.create(
          {
            customer: current_user.customer_id,
            client_reference_id: current_user.id,
            success_url: "http://localhost:3000",
            cancel_url: "http://localhost:3000",
            payment_method_types: %w[card konbini],
            mode: "payment",
            line_items: [{ price: price.id, quantity: 1 }],
            payment_method_options: {
              card: {
                setup_future_usage: "on_session"
              }
            },
            payment_intent_data: {
              application_fee_amount:
                (total_price * 0.05 + total_price * 0.036).to_i,
              transfer_data: {
                destination: User.find(@wallet_user).uid
              }
            }
          }
        )

      redirect_to session.url, allow_other_host: true
      flash[:notice] = "MOJIを贈りました。"
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

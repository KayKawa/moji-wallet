class TradeMessage
  include ActiveModel::Model
  attr_accessor :pay_u_id,
                :beneficiary_u_id,
                :unit_price,
                :quantity,
                :id,
                :user_id,
                :trade_id,
                :message,
                :created_at,
                :updated_at

  def save
    # 取引情報を保存し、変数transactionに代入する
    trade =
      Trade.create(
        pay_u_id: pay_u_id,
        beneficiary_u_id: beneficiary_u_id,
        unit_price: unit_price,
        quantity: quantity
      )
    # メッセージを保存する
    Message.new
    Message.create(user_id: user_id, trade_id: trade.id, message: message)
  end
end

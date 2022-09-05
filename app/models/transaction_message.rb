class TransactionMessage
  include ActiveModel::Model
  attr_accessor :pay_u_id,
                :beneficiary_u_id,
                :unit_price,
                :quantity,
                :user_id,
                :transaction_id,
                :message

  def save
    # 取引情報を保存し、変数transactionに代入する
    transaction =
      Transaction.create(
        pay_u_id: pay_u_id,
        beneficiary_u_id: beneficiary_u_id,
        unit_price: unit_price,
        quantity: quantity
      )
    # メッセージを保存する
    Message.create(
      user_id: user_id,
      transaction_id: transaction.id,
      message: message
    )
  end
end

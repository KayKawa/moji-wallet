class ChangeTransactionsToTrades < ActiveRecord::Migration[7.0]
  def change
    rename_table :transactions, :trades
  end
end

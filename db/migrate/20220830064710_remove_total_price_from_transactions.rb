class RemoveTotalPriceFromTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :total_price, :integer
  end
end

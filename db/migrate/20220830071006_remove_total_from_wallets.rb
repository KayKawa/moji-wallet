class RemoveTotalFromWallets < ActiveRecord::Migration[7.0]
  def change
    remove_column :wallets, :total, :integer
  end
end

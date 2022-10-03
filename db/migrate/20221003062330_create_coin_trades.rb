class CreateCoinTrades < ActiveRecord::Migration[7.0]
  def change
    create_table :coin_trades do |t|
      t.references :user, foreign_key: true
      t.references :coin, foreign_key: { to_table: :users }, index: true
      t.integer :quantity, null: false
      t.timestamps
    end
  end
end

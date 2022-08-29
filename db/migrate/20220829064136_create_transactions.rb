class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :relationship, foreign_key: true
      t.integer :unit_price, null: false
      t.integer :quantity, null: false
      t.integer :total_price, null: false
      t.timestamps
    end
  end
end

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :pay_u, foreign_key: { to_table: :users }, index: true
      t.references :beneficiary_u,
                   foreign_key: {
                     to_table: :users
                   },
                   index: true
      t.integer :unit_price, null: false
      t.integer :quantity, null: false
      t.integer :total_price, null: false
      t.timestamps
    end
  end
end

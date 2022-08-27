class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.references :user, foreign_key: true
      t.string :url, null: false
      t.integer :plus, null: false, default: 0
      t.integer :minus, null: false, default: 0
      t.integer :total, null: false, default: 0
      #Ex:- :default =>''
      t.timestamps
    end
  end
end

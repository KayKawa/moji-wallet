class CreateReturnTrades < ActiveRecord::Migration[7.0]
  def change
    create_table :return_trades do |t|
      t.references :user, foreign_key: true
      t.references :return_content, foreign_key: true
      t.timestamps
    end
  end
end

class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.references :transaction, foreign_key: true
      t.text :message, null: false
      t.timestamps
    end
  end
end

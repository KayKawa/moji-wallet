class CreateReturnContents < ActiveRecord::Migration[7.0]
  def change
    create_table :return_contents do |t|
      t.references :user, foreign_key: true
      t.text :name, null: false
      t.text :content_detail, null: false
      t.integer :cost, null: false
      t.timestamps
    end
  end
end

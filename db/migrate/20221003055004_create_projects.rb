class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.references :user, foreign_key: true
      t.text :title, null: false
      t.text :detail, null: false
      t.timestamps
    end
  end
end

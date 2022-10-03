class AddColumnUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :wallet_url, :string
    add_column :users, :coin_name, :string
  end
end

class RenameTradeColumnToMessages < ActiveRecord::Migration[7.0]
  def change
    rename_column :messages, :trade_id, :moji_trade_id
  end
end

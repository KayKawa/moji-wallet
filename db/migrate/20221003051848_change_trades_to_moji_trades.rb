class ChangeTradesToMojiTrades < ActiveRecord::Migration[7.0]
  def change
    rename_table :trades, :moji_trades
  end
end

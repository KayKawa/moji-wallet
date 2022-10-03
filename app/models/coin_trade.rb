class CoinTrade < ApplicationRecord
  belongs_to :user
  belongs_to :coin, class_name: "User", foreign_key: "coin_id"
end

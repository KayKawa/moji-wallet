class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :omniauthable,
         omniauth_providers: [:stripe_connect]
  has_one :wallet, dependent: :destroy
  accepts_nested_attributes_for :wallet
  has_one :profile, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :return_contents, dependent: :destroy
  has_many :return_trades, dependent: :destroy
  #MOJI支払ユーザー/受取ユーザー
  has_many :pay_moji_trades, class_name: "Moji_trade", foreign_key: "pay_u_id"
  has_many :beneficiary_moji_trades,
           class_name: "Moji_trade",
           foreign_key: "beneficiary_u_id"

  #  COIN受取ユーザー/コイン持ち主ユーザー
  has_many :coin_trades
  has_many :coin_trades, class_name: "Coin_trade", foreign_key: "coin_id"

  def can_receive_payments?
    uid? && provider? && access_code? && publishable_key?
  end

  private
end

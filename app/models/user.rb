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

  has_many :pay_transactions, class_name: "Trade", foreign_key: "pay_u_id"
  has_many :beneficiary_transactions,
           class_name: "Trade",
           foreign_key: "beneficiary_u_id"

  private
end

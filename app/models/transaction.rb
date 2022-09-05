class Transaction < ApplicationRecord
  belongs_to :pay_u, class_name: "User", foreign_key: "pay_u_id"
  belongs_to :beneficiary_u, class_name: "User", foreign_key: "beneficiary_u_id"
  has_one :message
end

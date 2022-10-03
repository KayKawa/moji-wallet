class ReturnTrade < ApplicationRecord
  belongs_to :user
  has_one :return_content
end

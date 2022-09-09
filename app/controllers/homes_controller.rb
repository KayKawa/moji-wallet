class HomesController < ApplicationController
  def index
    if user_signed_in?
      user = User.find(current_user.id)
      @wallet = Wallet.find_by(user_id: user)
    end
  end
end

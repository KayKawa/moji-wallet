class WalletsController < ApplicationController
  def show
    @wallet = Wallet.find_by(url: params[:url])
    wallet_user = @wallet.user_id
    user = User.find_by(id: wallet_user)
    @profile = user.profile
  end
end

class WalletsController < ApplicationController
  def show
    @wallet = Wallet.find_by(url: params[:url])
    wallet_user = @wallet.user_id
    user = User.find_by(id: wallet_user)
    @profile = user.profile

    # redirect_to "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{ENV["STRIPE_CLIENT_ID"]}&stripe_user[email]=#{current_user.email}&stripe_user[url]=http://localhost:3000/#{@wallet.url}&scope=read_write",
    #             allow_other_host: true
  end
end

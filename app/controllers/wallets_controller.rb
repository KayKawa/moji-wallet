class WalletsController < ApplicationController
  def show
    @wallet = Wallet.find_by(url: params[:url])
  end
end

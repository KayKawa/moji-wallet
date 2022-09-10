# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: %i[create new]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
    @wallet = @user.build_wallet
  end

  # POST /resource
  def create
    super

    # User新規登録時にProfileテーブルに初期データを保存する
    resource.build_profile
    resource.profile.introduction = "プロフィールを編集しよう！"
    resource.save
  end

  # GET /resource/edit
  def edit
    if user_signed_in?
      user = User.find(current_user.id)
      @wallet = Wallet.find_by(user_id: user)
    end
    customer =
      Stripe::Customer.create(
        { source: params[:stripeToken], email: resource.email }
      )
    user.customer_id = customer.id
    user.save
    super
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [
        :nickname,
        :birthday,
        wallet_attributes: %i[user_id url plus minus total]
      ]
    )
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(
  #     :account_update,
  #     keys: %i[nickname birthday]
  #   )
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

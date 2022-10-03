# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: %i[create new]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]

    customer =
      Stripe::Customer.create(
        { name: params[:user][:nickname], email: params[:user][:email] }
      )
    params[:user][:customer_id] = customer.id

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
      @account_link =
        Stripe::AccountLink.create(
          {
            account: current_user.uid,
            refresh_url: "http://localhost:3000/users/edit",
            return_url: "http://localhost:3000/users/edit",
            type: "account_onboarding"
          }
        )
    end

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
      keys: %i[nickname birthday wallet_url coin_name customer_id]
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

Rails.configuration.stripe = {
  #公開可能キーとシークレットキーを入れて下さい
  publishable_key: ENV["STRIPE_PUBLISHABLE_KEY"],
  secret_key: ENV["STRIPE_SECRET_KEY"]
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
Stripe.api_version = "2022-08-01"

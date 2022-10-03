# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_03_062330) do
  create_table "coin_trades", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "coin_id"
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_coin_trades_on_coin_id"
    t.index ["user_id"], name: "index_coin_trades_on_user_id"
  end

  create_table "messages", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "moji_trade_id"
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["moji_trade_id"], name: "index_messages_on_moji_trade_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "moji_trades", charset: "utf8", force: :cascade do |t|
    t.bigint "pay_u_id"
    t.bigint "beneficiary_u_id"
    t.integer "unit_price", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beneficiary_u_id"], name: "index_moji_trades_on_beneficiary_u_id"
    t.index ["pay_u_id"], name: "index_moji_trades_on_pay_u_id"
  end

  create_table "profiles", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.text "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "projects", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.text "title", null: false
    t.text "detail", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "return_contents", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.text "name", null: false
    t.text "content_detail", null: false
    t.integer "cost", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_return_contents_on_user_id"
  end

  create_table "return_trades", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "return_content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["return_content_id"], name: "index_return_trades_on_return_content_id"
    t.index ["user_id"], name: "index_return_trades_on_user_id"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "nickname", null: false
    t.date "birthday", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.string "provider"
    t.string "access_code"
    t.string "publishable_key"
    t.string "customer_id"
    t.string "wallet_url"
    t.string "coin_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "url", null: false
    t.integer "plus", default: 0, null: false
    t.integer "minus", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "coin_trades", "users"
  add_foreign_key "coin_trades", "users", column: "coin_id"
  add_foreign_key "messages", "moji_trades"
  add_foreign_key "messages", "users"
  add_foreign_key "moji_trades", "users", column: "beneficiary_u_id"
  add_foreign_key "moji_trades", "users", column: "pay_u_id"
  add_foreign_key "profiles", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "return_contents", "users"
  add_foreign_key "return_trades", "return_contents"
  add_foreign_key "return_trades", "users"
  add_foreign_key "wallets", "users"
end

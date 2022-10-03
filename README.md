# テーブル設計

## User テーブル/会員情報

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| id                 |        |             |
| nickname           | string | null: false |
| birthday           | date   | null: false |
| email              | string | null: false |
| wallet_url         | string | null: false |
| coin_name          | string | null: false |
| encrypted_password | string | null: false |
| uid                | string |             |
| provider           | string |             |
| access_code        | string |             |
| publishable_key    | string |             |
| customer_id        | string |             |

### User-Association

- has_one :profile
- has_one :project
- has_many :return_trades
- has_many :return_contents
  <!-- MOJI支払ユーザー/受取ユーザー -->
- has_many :pay_moji_trades, class_name: 'Moji_trade', foreign_key:'pay_u_id'
- has_many :beneficiary_moji_trades, class_name: 'Moji_trade', foreign_key:'beneficiary_u_id'
  <!-- COIN受取ユーザー/コイン持ち主ユーザー -->
- has_many :coin_trades
- has_many :coin_trades, class_name: 'Coin_trade', foreign_key:'coin_id'

## Profile テーブル/会員のプロフィール情報

| Column       | Type       | Options           |
| ------------ | ---------- | ----------------- |
| id           |            |                   |
| user_id      | references | foreign_key: true |
| introduction | text       |                   |

### Profile-Association

- belongs_to :user

## Project テーブル/会員のプロジェクト情報

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| id      |            |                   |
| user_id | references | foreign_key: true |
| title   | text       | null: false       |
| detail  | text       | null: false       |

### Project-Association

- belongs_to :user

## Return_trade テーブル/会員のリターン購入情報

| Column            | Type       | Options           |
| ----------------- | ---------- | ----------------- |
| id                |            |                   |
| user_id           | references | foreign_key: true |
| return_content_id | references | foreign_key: true |

### Return_trade-Association

- belongs_to :user
- has_one :return_content

## Return_content テーブル/会員のリターンコンテンツ情報

| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| id             |            |                   |
| user_id        | references | foreign_key: true |
| name           | text       | null: false       |
| content_detail | text       | null: false       |
| cost           | integer    | null: false       |

### Return_content-Association

- belongs_to :user
- belongs_to :return_trade

## Coin_trade テーブル/会員のコイン情報

| Column   | Type       | Options           |
| -------- | ---------- | ----------------- |
| id       |            |                   |
| user_id  | references | foreign_key: true |
| coin_id  | references | foreign_key: true |
| quantity | integer    | null: false       |

### Coin_trade-Association

- belongs_to :user
- belongs_to :coin, class_name: 'User', foreign_key:'coin_id'

## Moji_trade テーブル/会員の MOJI 取引情報

| Column           | Type       | Options           |
| ---------------- | ---------- | ----------------- |
| id               |            |                   |
| pay_u_id         | references | foreign_key: true |
| beneficiary_u_id | references | foreign_key: true |
| unit_price       | integer    | null: false       |
| quantity         | integer    | null: false       |

### Moji_trade-Association

- belongs_to :pay_u, class_name: 'User', foreign_key:'pay_u_id'
- belongs_to :beneficiary_u, class_name: 'User', foreign_key:'beneficiary_u_id'
- has_one :message

## Messages テーブル/会員の贈った MOJI のメッセージ情報

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| id            |            |                   |
| user_id       | references | foreign_key: true |
| moji_trade_id | references | foreign_key: true |
| message       | text       | null: false       |

### Message-Association

- belongs_to :moji_trade

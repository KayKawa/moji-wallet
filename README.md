# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| id                 |        |             |
| nickname           | string | null: false |
| birthday           | date   | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |

### User-Association

- has_one :profile
- has_one :wallet
- has_many :messages

- has_many :transactions
- has_many :beneficiaries, through: :transactions, source: :beneficiary
- has_many :giver_of_transactions, class_name: 'Transaction', foreign_key: 'beneficiary_id'
- has_many :givers, through: :giver_of_transactions, source: :user

## profiles テーブル

| Column       | Type       | Options           |
| ------------ | ---------- | ----------------- |
| id           |            |                   |
| user_id      | references | foreign_key: true |
| introduction | text       |                   |

### Profile-Association

- belongs_to :user

## wallets テーブル

| Column  | Type       | Options                 |
| ------- | ---------- | ----------------------- |
| id      |            |                         |
| user_id | references | foreign_key: true       |
| url     | string     | null: false             |
| plus    | integer    | null: false, default: 0 |
| minus   | integer    | null: false, default: 0 |
| total   | integer    | null: false, default: 0 |

### Wallet-Association

- belongs_to :user

## transactions テーブル

| Column         | Type       | Options                           |
| -------------- | ---------- | --------------------------------- |
| id             |            |                                   |
| user_id        | references | foreign_key: true                 |
| beneficiary_id | references | foreign_key: { to_table: :users } |
| unit_price     | integer    | null: false                       |
| quantity       | integer    | null: false                       |
| total_price    | integer    | null:false                        |

### Transaction-Association

- belongs_to :user
- belongs_to :beneficiary, class_name: 'User'
- has_one :message

## messages テーブル

| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| id             |            |                   |
| user_id        | references | foreign_key: true |
| transaction_id | references | foreign_key: true |
| message        | text       | null: false       |

### Message-Association

- belongs_to :user
- belongs_to :transaction

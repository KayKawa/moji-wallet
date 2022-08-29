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
- has_many :relationships, foreign_key: :pay_u_id
- has_many :relationships, foreign_key: :beneficiary_u_id

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

## relationships テーブル

| Column           | Type       | Options                           |
| ---------------- | ---------- | --------------------------------- |
| id               |            |                                   |
| pay_u_id         | references | foreign_key: { to_table: :users } |
| beneficiary_u_id | references | foreign_key: { to_table: :users } |

### Relationship-Association

- belongs_to :pay_u, class_name: 'User', foreign_key: :pay_u_id
- belongs_to :beneficiary_u, class_name: 'User', foreign_key: :beneficiary_u_id
- has_many :transactions

## transactions テーブル

| Column          | Type       | Options           |
| --------------- | ---------- | ----------------- |
| id              |            |                   |
| relationship_id | references | foreign_key: true |
| unit_price      | integer    | null: false       |
| quantity        | integer    | null: false       |
| total_price     | integer    | null:false        |

### Transaction-Association

- belongs_to :relationship
- has_one :message

## messages テーブル

| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| id             |            |                   |
| user_id        | references | foreign_key: true |
| transaction_id | references | foreign_key: true |
| message        | text       | null: false       |

### Message-Association

- belongs_to :transaction

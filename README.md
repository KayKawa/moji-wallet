# テーブル設計

## USER テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| id                 |        |             |
| nickname           | string | null: false |
| birthday           | date   | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| uid                |        |             |
| provider           |        |             |
| access_code        |        |             |
| publishable_key    |        |             |

### User-Association

- has_one :profile
- has_one :wallet
- has_many :pay_transactions, class_name: 'Trade', foreign_key:'pay_u_id'
- has_many :beneficiary_transactions, class_name: 'Trade', foreign_key:'beneficiary_u_id'

## PROFILE テーブル

| Column       | Type       | Options           |
| ------------ | ---------- | ----------------- |
| id           |            |                   |
| user_id      | references | foreign_key: true |
| introduction | text       |                   |

### Profile-Association

- belongs_to :user

## WALLET テーブル

| Column  | Type       | Options                 |
| ------- | ---------- | ----------------------- |
| id      |            |                         |
| user_id | references | foreign_key: true       |
| url     | string     | null: false             |
| plus    | integer    | null: false, default: 0 |
| minus   | integer    | null: false, default: 0 |

### Wallet-Association

- belongs_to :user

## TRADE テーブル

| Column           | Type       | Options           |
| ---------------- | ---------- | ----------------- |
| id               |            |                   |
| pay_u_id         | references | foreign_key: true |
| beneficiary_u_id | references | foreign_key: true |
| unit_price       | integer    | null: false       |
| quantity         | integer    | null: false       |

### Transaction-Association

- belongs_to :pay_u, class_name: 'User', foreign_key:'pay_u_id'
- belongs_to :beneficiary_u, class_name: 'User', foreign_key:'beneficiary_u_id'
- has_one :message

## messages テーブル

| Column   | Type       | Options           |
| -------- | ---------- | ----------------- |
| id       |            |                   |
| user_id  | references | foreign_key: true |
| trade_id | references | foreign_key: true |
| message  | text       | null: false       |

### Message-Association

- belongs_to :trade

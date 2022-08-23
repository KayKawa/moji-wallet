# テーブル設計

## users テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| id                 |            |             |
| nickname           | string     | null: false |
| birthday           | date       | null: false |
| email              | string     | null: false |
| encrypted_password | string     | null: false |
| profile_id         | references |             |
| wallet_id          | references |             |

### Users-Association

- has_one :profile
- has_one :wallet
- has_many :transactions
- has_many :messages

## profiles テーブル

| Column       | Type       | Options |
| ------------ | ---------- | ------- |
| id           |            |         |
| user_id      | references |         |
| introduction | text       |         |

### Profiles-Association

- belongs_to :user

## wallets テーブル

| Column  | Type       | Options                 |
| ------- | ---------- | ----------------------- |
| id      |            |                         |
| user_id | references |                         |
| url     | string     | null: false             |
| plus    | integer    | null: false, default: 0 |
| minus   | integer    | null: false, default: 0 |
| total   | integer    | null: false, default: 0 |

### Wallets-Association

- belongs_to :user

## transactions テーブル

| Column         | Type       | Options                             |
| -------------- | ---------- | ----------------------------------- |
| id             |            |                                     |
| giver_id       | references | foreign_key: { to_table: :users }   |
| beneficiary_id | references | foreign_key: { to_table: :wallets } |
| unit_price     | integer    | null: false                         |
| quantity       | integer    | null: false                         |
| total_price    | integer    | null:false                          |

### Association

- belongs_to :user
- belongs_to :wallet
- has_one :message

## messages テーブル

| Column         | Type       | Options     |
| -------------- | ---------- | ----------- |
| id             |            |             |
| sender_id      | references |             |
| receiver_id    | references |             |
| transaction_id | references |             |
| message        | text       | null: false |
|                |            |             |

### Association

- belongs_to :user
- belongs_to :transaction

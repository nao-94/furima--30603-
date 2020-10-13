# README

## users テーブル

| Column            | Type   | Options                       |
| ----------------- | ------ | ----------------------------- |
| nickname          | string | null: false, uniqueness: true |
| email             | string | null: false, uniqueness: true |
| password          | string | null: false |
| last_name         | string | null: false |
| first_name        | string | null: false |
| last_name_kana    | string | null: false |
| first_name_kana   | string | null: false |
| birth_day         | date   | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column            | Type        | Options                        |
| ----------------- | ----------- | ------------------------------ |
| user              | references  | null: false, foreign_key: true |
| name              | string      | null: false |
| description       | text        | null: false |
| condition_id      | integer     | null: false |
| postage_payer_id  | integer     | null: false |
| prefecture_id     | integer     | null: false |
| handing_time_id   | integer     | null: false |
| price             | integer     | null: false |


### Association

-  belongs_to :user
-  has_one    :purchase
-  belongs_to_active_hash :category
-  belongs_to_active_hash :condition
-  belongs_to_active_hash :handing_time
-  belongs_to_active_hash :postage_payer


## address テーブル

| Column          | Type        | Options                        |
| --------------- | ----------- | ------------------------------ |
| post_code       | string      | null: false |
| prefectures_id  | integer     | null: false, foreign_key: true |
| city            | string      | null: false |
| building_name   | string      |
| house_number    | string      | null: false |
| phone_number    | string      | null: false, uniqueness: true  |
| purchase        | references  | null: false, foreign_key: true |

### Association

-  belongs_to :purchase
-  belongs_to_active_hash :prefecture

## purchases テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| item      | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

### Association

-  belongs_to :user
-  belongs_to :item
-  has_one    :address

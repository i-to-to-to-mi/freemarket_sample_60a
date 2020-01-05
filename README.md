# DB設計

## usersテーブル
|Column|Type|Options|
|---------|------|---------|
|nickname|string|null: false| 
|email|text|null: false, unique: true|
|password|text|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null;false|
|last_name_kana|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|introduction|text||
|avatar|string||
### Association
- has_one :card
- has_one :buyer
- has_one :seller
- has_one :comment
- has_many :likes
- has_one :phone
- has_one :address

## Phoneテーブル
|phone_number|integer|null: false, unique: true|
|authentication_num|integer|null: false|
### Association
- belongs_to :user

## Addressテーブル
|postal_code|integer|null: false|
|Prefectures|string|null: false|
|city|string|null: false|
|address1|string|null: false|
|address2|string||
|address_phone_number|integer||
### Association
- belongs_to :user


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|created_at|integer|null: false|
|updated_at|integer|null: false|
|name|string|null: false|
|description|string|null: false|
|condition|string|null: false|
|cover_postage|string|null: false|
|shipping_area|string|null: false|
|shipping_date|string|null: false|
|price|integer|null: false|
|margin|integer|null: false|
|profit|integer|null: false|
|category_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, primary_key: true, index: true|
|buyer_id|integer|null: false, foreign_key: true|
|seller_id|integer|null: false, foreign_key: true|
|brand_id|integer|null: false, foreign_key: true、index: true|
|main_image|string|null: false|
|image_2|string|null: false|
|image_3|string|none|
|image_5|string|none|
|image_6|string|none|
|image_7|string|none|
|image_8|string|none|
|image_9|string|none|
|image_10|string|none|

### Association
- has_one :buyer
- has_one :seller
- has_one :category
- has_one :brand
- has_many :comments
- has_many: likes

## likesテーブル
|user_id|integer|null: false, uniqueness: {scope: :item_id}|
|item_id|integer|null: false|
|created_at|integer|null: false|

###Association
- belongs_to: user
- belongs_to: item

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items
- has_many :groups, through: :brand_groups

## brand_groupsテーブル
|Column|Type|Options|
|------|----|-------|
|brand_id|integer|null: false, index: true|
|group_id|integer|null: false, |
### Association
- has_many :brands
- has_many :groups

## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :brands, through: :brand_groups

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_meny :items
- has_ancestry

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|customer_id|string|null: false|
|card_id|string|null: false|
### Association
- belongs_to :user
- belongs_to :customer
- belongs_to :card

## buyersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## sellersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|body|text|null: false|
|user_id|integer|null: false, foreign_key: true, index: true|
|item_id|integer|null: false, foreign_key: true, index: true|
### Association
- belongs_to :user
- belongs_to :item

# DB設計

## usersテーブル
|Column|Type|Options|
|---------|------|---------|
|nickname|string|null: false| 
<!-- nicknameはunique: trueしなくてもよい？ -->
|email|text|null: false, unique: true|
|password|text|null: false|
<!-- user登録時のページ見てないですが、password_confirmationは不要？ -->
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null;false|
|last_name_kana|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|phone_number|integer|null: false, unique: true|
|authentication_num|integer|null: false|
|postal_code|integer|null: false|
|Prefectures|string|null: false|
|city|string|null: false|
|address1|string|null: false|
|address2|string||
|address_phone_number|integer||
|introduction|text||
<!-- 上３つはオプションなしの任意入力って認識でOKですかね -->
### Association
- has_one :card
- has_one :buyer
- has_one :seller
- has_one :comment
<!-- has_many :commentsではない？ -->

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|created_at|integer|null: false|
|updated_at|integer|null: false|
|name|string|null: false|
|item_description|string|null: false|
<!-- カラム名はdescriptionでいいんじゃないかな？ -->
|condition|string|null: false|
|who_to_cover_shipping_cost|string|null: false|
<!-- cover_postageとかpostageとか短い方が読みやすいかと -->
|where_item_dispatched_from|string|null: false|
<!-- shipping_areaとかreligeonとか、、、？ -->
|days_till_dispatchment|string|null: false|
<!-- shipping_dateとか？ -->
|price|integer|null: false|
|margin|integer|null: false|
|profit|integer|null: false|
|category_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, primary_key: true, index: true|
|buyer_id|integer|null: false, foreign_key: true|
|seller_id|integer|null: false, foreign_key: true|
|brand_id|integer|null: false, foreign_key: true、index: true|
### Association
- has_one :buyer
- has_one :seller
- has_one :category
- has_one :brand
- has_many :comments
- has_many :images

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image_id|integer|null: false, primary_key: true|
|image|string|null: false|
|item_id|integer|null: false, foreign_key: true, index: true|
### Association
- belongs_to 
<!-- - belongs_to :item アソシエーションはitemでいいのかな？プロフィール画像も含むか？そしたらuserも？ -->



## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items
- has_many :groups, through: :brand_groups
<!-- アソシエーション分からなくなってしまいました。brand_groupsテーブルは中間だからthrough？？ -->

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
<!-- アソシエーション分からなくなってしまいました。brand_groupsテーブルは中間だからthrough？？ -->

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

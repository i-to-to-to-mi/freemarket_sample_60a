class Item < ApplicationRecord

  # validation
  validates :name, :description,:condition, :cover_postage, :prefectures, :shipping_date, :price, :seller_id , :category, presence: true
  validates :name, length: { in: 1..40}, presence: true
  validates :description, length: { in: 1..1000}, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 300, less_than: 9999999}

  include AASM

  aasm do
  # 状態の説明

  # 出品中(selling)

  # 出品停止中(pending)

  # 取引中(dealing)

  # 売却済み(completed)
    state :selling, :initial => true
    state :pending, :dealing, :completed

 
    # 出品中＝＞出品停止中

    event :stop_sales do
      transitions :from => :selling, :to => :pending
    end


    # 出品中＝＞取引中
    event :sold do
      transitions :from => :selling, :to => :dealing
    end


    # 取引中＝＞売却済み
    event :closing do
      transitions :from => :dealing, :to => :completed
    end

  end

  has_many :images
  accepts_nested_attributes_for :images
  belongs_to :user, optional: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  enum prefectures:{
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }


  

end



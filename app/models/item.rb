class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :seller, class_name:"User"
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :category


  # validation
  validates :name, :description,:condition, :cover_postage, :prefectures, :shipping_date, :price, :seller_id , :category, presence: true
  validates :name, length: { in: 1..40}, presence: true
  validates :description, length: { in: 1..1000}, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 9999999}

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
end



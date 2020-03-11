class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  mount_uploader :avatar, ImageUploader

  # バリデーション
  validates :nickname, :first_name, :last_name, :birth_year, :birth_month, :birth_day, presence: true, on: :sign_up
  validates :password, presence: true, length: { minimum: 7 }, 
            # 英数字のみ可
            format: { with: /\A[a-z0-9]+\z/i, message: "は半角英数字７文字以上で入力してください" }, on: :sign_up
  validates :email, presence: true, 
            # 重複不可
            uniqueness: { case_sensitive: false }, 
            # 英数字のみ可,@を挟んだemailの形になっているか
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "は不正な文字が使われています。たぶん。" }
  validates :last_name_kana, :first_name_kana, presence: true, 
            # カナのみ可
            format: { with: /\A([ァ-ン]|ー)+\z/, message: "はカタカナで入力してください" }

  has_many :sns_credentials
  has_one :address
  has_many :items
  has_many :cards


  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  mount_uploader :avatar, ImageUploader

  # バリデーション
  # validates :nickname, :firstname, :lastname, :birthday, presence: true
  # validates :password, presence: true, length: { minimum: 7 }, 
  #           # 英数字のみ可
  #           format: { with: /\A[a-z0-9]+\z/i, message: "is must NOT contain any other characters than alphanumerics." }
  # validates :email, presence: true, 
  #           # 重複不可
  #           uniqueness: { case_sensitive: false }, 
  #           # 英数字のみ可,@を挟んだemailの形になっているか
  #           format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "is must NOT contain any other characters than alphanumerics." }
  # validates :kana_firstname, :kana_lastname, presence: true, 
  #           # カナのみ可
  #           format: { with: /\A([ァ-ン]|ー)+\z/, message: "is must NOT contain any other characters than alphanumerics." }
  has_many :sns_credentials
  has_one :address


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
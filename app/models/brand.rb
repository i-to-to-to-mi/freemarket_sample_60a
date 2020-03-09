class Brand < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :items
end
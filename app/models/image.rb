class Image < ApplicationRecord
  mount_uploader :src, ImageUploader
  belongs_to :item, optional: true
  validates :src, :item_id, presence: true
end

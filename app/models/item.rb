class Item < ApplicationRecord
  mount_uploader :avatar, ImageUploader
end

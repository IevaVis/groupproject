class Article < ApplicationRecord
  mount_uploader :image, AvatarUploader
  belongs_to :user
  validates :link, uniqueness: true
end

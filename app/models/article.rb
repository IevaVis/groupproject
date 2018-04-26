class Article < ApplicationRecord
  # mount_uploader :image, AvatarUploader
  belongs_to :user
  validates :link, uniqueness: true

  def self.search(search)
  	where("title LIKE ?",  "%#{search}%" )
  end
end

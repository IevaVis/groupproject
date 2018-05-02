class Article < ApplicationRecord
  # mount_uploader :image, AvatarUploader
  belongs_to :user
  has_many :posts
  has_many :comments
  validates :link, uniqueness: true

  def self.search(search)
  	where("title ILIKE ?",  "%#{search}%" )
  end

  def self.tag_search(tag)
    where("? = ANY(tags)", "#{tag}")
  end
end

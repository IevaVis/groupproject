class Article < ApplicationRecord
  belongs_to :user
  validates :link, uniqueness: true
end

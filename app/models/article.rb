class Article < ApplicationRecord
  belongs_to :user

  def self.search(search)
  	where("title LIKE ?",  "%#{search}%" )
  end
end

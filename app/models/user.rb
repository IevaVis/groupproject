class User < ApplicationRecord
  include Clearance::User
    enum role: [:regular, :expert, :admin]
  	validates :first_name, :last_name, presence: true
	validates :email, uniqueness: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

end

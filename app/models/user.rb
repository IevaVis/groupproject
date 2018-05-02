class User < ApplicationRecord
  include Clearance::User
    enum role: [:regular, :expert, :admin]
    has_many :articles
    has_many :posts
    has_many :comments
   	has_many :authentications, dependent: :destroy
    mount_uploader :avatar, AvatarUploader
  	validates :first_name, :last_name, presence: true


 def self.create_with_auth_and_hash(authentication, auth_hash, role)
  
   user = self.create!(

     first_name: auth_hash["info"]["first_name"],
     last_name: auth_hash["info"]["last_name"],
     email: auth_hash["info"]["email"],
     password: SecureRandom.hex(10),
     role: role
   )
   user.authentications << authentication
   return user
 end

 def google_token
   x = self.authentications.find_by(provider: 'google_oauth2')
   return x.token unless x.nil?
 end


 def name
    first_name + " " + last_name
  end

 end

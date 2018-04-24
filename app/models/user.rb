class User < ApplicationRecord
  include Clearance::User
  enum role: [:regular, :expert, :admin]
end

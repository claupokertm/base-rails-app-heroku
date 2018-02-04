class User < ApplicationRecord
  has_secure_password
  enum role: [:basic, :admin]
end

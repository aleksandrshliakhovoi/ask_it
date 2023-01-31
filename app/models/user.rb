class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  # validates :name, presence: true

  has_secure_password # add authenticate save password into the password_digest
end

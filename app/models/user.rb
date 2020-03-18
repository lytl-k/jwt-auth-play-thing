class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save do
    self.email = email.downcase
  end

  validates :name,      presence: true, length: { maximum: 50 },
                        uniqueness: { case_sensitive: false }
  validates :surname,   presence: true, length: { maximum: 50 },
                        uniqueness: { case_sensitive: false }
  validates :email,     presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }

  has_secure_password
end

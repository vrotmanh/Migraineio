class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :kind, presence: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :algorithms, dependent: :destroy
  has_many :reports, dependent: :destroy
end

class User < ApplicationRecord
  before_save :email_downcase

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.{12,})/x

  USERS_PARAMS = %i(nickname email password password_confirmation).freeze

  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :nickname, presence: true, length: { maximum: 50 }, uniqueness: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 12 }, format: { with: VALID_PASSWORD_REGEX,
            message: "英数字大文字小文字が1文字以上、長さは12文字以上含む必要があります"}

  private

  def email_downcase
    email.downcase!
  end
end

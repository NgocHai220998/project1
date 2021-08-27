class User < ApplicationRecord
  has_many :spot_reviews, dependent: :destroy

  attr_accessor :remember_token

  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  VALID_PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.{12,})/x.freeze

  USERS_PARAMS = %i[nickname email password password_confirmation].freeze

  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :nickname, presence: true, length: { maximum: 50 }, uniqueness: true

  validates :password, length: { minimum: 12 }, format: { with: VALID_PASSWORD_REGEX,
                                                          message: 'は英数字大文字小文字が1文字以上、長さは12文字以上含む必要があります' }

  has_secure_password

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update(remember_digest: User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update(remember_digest: nil)
  end
end

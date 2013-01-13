class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :role_id, :remember_token
  has_secure_password

  has_many :adverts, dependent: :destroy
  belongs_to :role

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name,  presence: true,
                    length: { minimum: 3, maximum: 24 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensetive: false}
  validates :password, presence: true,
                       length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def feed
    adverts
  end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end

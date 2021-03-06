  class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true
  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :username, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_many :hotels
  has_many :comments
  before_create :generate_remember_token

  def admin?
    self.role == 'admin'
  end

  def hotel?
    self.role == 'hotel'
  end

  private
  def generate_remember_token
    self.remember_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(remember_token: random_token)
    end
    self.reset_password_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(reset_password_token: random_token)
    end
  end
end

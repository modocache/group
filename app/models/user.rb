class User < ActiveRecord::Base
  include HasUuid

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :posts

  validates :email, presence: true, uniqueness: true

  def self.find_or_create_by_auth_hash(auth_hash)
    begin
      email = auth_hash['info']['email']
    rescue NoMethodError
      nil
    else
      self.find_or_create_by_email(email)
    end
  end

  def avatar_url
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=24"
  end
end

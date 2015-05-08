class User < ActiveRecord::Base;
  has_many :posts
  has_many :comments
  has_many :votes
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  before_save :generate_slug

  def to_param
    self.slug
  end

  def generate_slug
    self.slug ||= username.parameterize if username
  end
end

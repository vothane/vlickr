require "copy"

class User < ActiveRecord::Base 
  serialize :player, Player

  has_many :albums, dependent: :destroy, :extend => Copy
  has_many :videos, dependent: :destroy
  has_many :comments, :as => :commentable
  
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save Proc.new { |user| user.email.downcase! }
  #before_destroy Proc.new { |player| player.video.destroy }
  before_save :create_remember_token

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :player, :presence => true  
  
  has_secure_password
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 6 }
  
  delegate :player_code, :to => :player 

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def feed
    Comment.from_users_followed_by(self)
  end

  private
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end 
end
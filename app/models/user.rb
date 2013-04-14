require "copy"

class User < ActiveRecord::Base 
  serialize :player, Player

  has_many :albums, dependent: :destroy, :extend => Copy
  has_many :videos, dependent: :destroy, :autosave => true

  before_save Proc.new { |user| user.email.downcase! }
  before_destroy Proc.new { |player| player.video.destroy }
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

  private
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end 
end
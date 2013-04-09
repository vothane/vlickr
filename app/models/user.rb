require "copy"

class User < ActiveRecord::Base 
  serialize :player, Player

  has_many :albums, dependent: :destroy, :extend => Copy
  has_many :videos, dependent: :destroy, :autosave => true

  before_save Proc.new { |user| user.email.downcase! }
  after_create :create_player
  before_destroy Proc.new { |player| player.video.destroy }

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :player, :presence => true  

  delegate :player_id, :to => :player    

  private

  def create_player
    player = Player.new
    player.name = "player for #{user_name}"
    self.player = player
  end   

end
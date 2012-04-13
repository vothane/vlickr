class User < ActiveRecord::Base
  attr_accessor :name, :email

  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :followers,     :through => :relationships, :class_name => "User", :source => "user_id"
  has_many :follows,       :through => :relationships, :class_name => "User", :source => "follower_id"
  has_many :albums,        :dependent => :destroy
  has_many :videos,        :through => :albums, :dependent => :destroy
  has_many :comments,      :dependent => :destroy

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  :presence   => true,
                    :length     => { :maximum => 50 }
  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  def follow(user)
    Relationship.create(:user => user, :follower => self)
  end

  def unfollow(user)
    Relationship.first(:user_id => user.id, :follower_id => self.id).destroy
  end

  def create_video
    #
  end
end
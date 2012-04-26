class User < ActiveRecord::Base
  attr_accessor :name, :email

  has_many :relationships,  :foreign_key => "follower_id", :dependent => :destroy
  has_many :follows,        :through     => :relationships, :class_name => "User", :source => "follower_id"
  has_many :albums,         :dependent   => :destroy
  has_many :videos,         :through     => :albums, :dependent => :destroy
  has_many :comments,       :dependent   => :destroy
  has_many :followed_users, :through     => :relationships, :source => :followed
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name  => "Relationship",
                                   :dependent   => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower

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

  def following?(other_user)
    self.relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    self.relationships.create!(followed_id => other_user.id)
  end

  def unfollow!(other_user)
    self.relationships.find_by_followed_id(other_user.id).destroy
  end
end
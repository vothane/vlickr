class Album < ActiveRecord::Base
  attr_accessor :name, :description

  belongs_to :user
  has_many   :videos
  
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }
  
  validates :email, :presence   => true,
                    :uniqueness => { :case_sensitive => false }
                    
  after_create :create_ooyala_label
  
  private
  
  def create_ooyala_label
    label = Lable.new
    label.name = :name
    label.save
  end  
end
class Album < ActiveRecord::Base
  attr_accessor :title, :description

  belongs_to :user
  has_many   :videos
  
  validates :title, :presence => true,
                    :length   => { :maximum => 50 }
  
  validates :description, :presence   => true
                    
  after_create :create_ooyala_label
  
  private
  
  def create_ooyala_label
    #label = Lable.new
    #label.name = :name
    #label.save
  end  
end
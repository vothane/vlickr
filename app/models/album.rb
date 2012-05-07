class Album < ActiveRecord::Base
  attr_accessor :title, :description

  belongs_to :user
  has_many   :videos

  validates :user_id,     :presence => true
  validates :title,       :presence => true,
                          :length   => { :maximum => 50 } 
  validates :description, :presence => true
                    
  after_create :create_ooyala_label
  
  private
  
  def create_ooyala_label
    Label::create_label(:title)
  end  
end
class Comment < ActiveRecord::Base
  attr_accessor :content

  belongs_to :video

  default_scope order: 'comments.created_at DESC'

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :video_id, :presence => true
end
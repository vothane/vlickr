class Comment < ActiveRecord::Base
  belongs_to :video

  validates :content, presence: true, length: { maximum: 140 }
  validates :video_id, presence: true
end

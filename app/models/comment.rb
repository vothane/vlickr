
<!-- saved from url=(0100)https://raw.github.com/vothane/vlickr/174f56051ff35bfae5ef46fcfad06b6968443bf4/app/models/comment.rb -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head><body><pre style="word-wrap: break-word; white-space: pre-wrap;">class Comment &lt; ActiveRecord::Base
  belongs_to :video

  validates :content, presence: true, length: { maximum: 140 }
  validates :video_id, presence: true
end
</pre></body></html>
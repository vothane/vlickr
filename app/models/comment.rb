class Comment < ActiveRecord::Base
  attr_accessor :remark

  belongs_to :user
  belongs_to :video
end
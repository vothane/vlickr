class LandingPagesController < ApplicationController
  def home
    @recent_videos = Video.recent
  end

  def help
  end
end

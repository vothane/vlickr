class LandingPagesController < ApplicationController
  def home
    @player_id     = Player.default_player
    @recent_videos = Video.recent
  end

  def help
  end
end

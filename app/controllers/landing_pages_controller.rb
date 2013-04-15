class LandingPagesController < ApplicationController

  def home
    @player_id     = Player.default_player
    @recent_videos = Video.recent

    if signed_in?
      @comment  = Comment.new
    end
  end

  def help
  end
end

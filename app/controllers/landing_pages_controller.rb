class LandingPagesController < ApplicationController

  def home
    @player_id     = Player.default_player
    @recent_videos = Video.recent

    if signed_in?
      @comment  = current_user.comments.build
    end
  end

  def help
  end
end

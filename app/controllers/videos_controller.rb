class VideosController < ApplicationController

  before_action :get_user

  def get_user
    @user = User.find(params[:user_id].to_i)
  end
    
  def index
  end

  def show
    @player_id = Player.default_player.player_code
    @video     = Video.find(params[:id].to_i)
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

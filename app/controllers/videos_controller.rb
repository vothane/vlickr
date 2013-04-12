class VideosController < ApplicationController

  before_action :get_user

  def get_user
    @user = User.find(params[:user_id].to_i)
  end
    
  def index
  end

  def show
    show_params = params.permit(:id)
    @player_id = Player.default_player.player_code
    @video     = Video.find(show_params[:id].to_i)
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

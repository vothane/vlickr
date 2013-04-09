class VideosController < ApplicationController

  before_action :get_user

  def get_user
    @user = User.find(:user_id)
  end
    
  def index
  end

  def show
    @player_id = @user.player_id
    @video     = Video.find(:id)
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

class VideosController < ApplicationController
  def index
  end

  def show
    user = User.find(:id)
    @player_id = user.player_id
    @video = Video.find(:id)
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

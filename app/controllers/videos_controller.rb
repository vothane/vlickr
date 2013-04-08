class VideosController < ApplicationController
  def index
  end

  def show
    #user = User.find(:id)
    @player_id = "NDY2MTE5OTY2NjMwMDVkOTExNTU4ZDAz"#user.player_id
    @video = (Video.all).first
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

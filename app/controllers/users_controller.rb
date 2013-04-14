class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @videos = @user.videos
  end

  def new
  	@user = User.new
  end
end

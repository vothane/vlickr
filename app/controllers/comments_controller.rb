class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])

    if @comment.save
      flash[:success] = "comment created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'landing_pages/home'
    end
  end
  
  def destroy
    @comment.destroy
    redirect_to root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
  
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
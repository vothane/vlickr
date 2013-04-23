class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    response.headers["Content-Type"] = "text/javascript"

    attributes = params.require(:comment).permit(:content)
    @commentable = find_commentable
    @comment = current_user.comments.build(params[:content])

    if @comment.save
      flash[:success] = "comment created!"

      @message = Comment.create(attributes)
      $redis.publish('comments.create', @comment.to_json)

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
  
  def events
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    redis.psubscribe('comments.*') do |on|
      on.pmessage do |pattern, event, data|
        response.stream.write("event: #{event}\n")
        response.stream.write("data: #{data}\n\n")
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close
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
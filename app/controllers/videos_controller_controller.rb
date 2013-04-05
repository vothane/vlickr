class VideosControllerController < ApplicationController
  
  include ActionController::Live

  def index
    @videos = Video.all
  end

  def create
    attributes = params.require(:message).permit(:name)
    response.headers["Content-Type"] = "text/javascript"
    live_message("create")
  end

  def destroy
    response.headers["Content-Type"] = "text/javascript"
    live_message("destroy")
  end

  def edit
    attributes = params.require(:message).permit(:name)
    response.headers["Content-Type"] = "text/javascript"
    live_message("edit")
  end

  def update
    attributes = params.require(:message).permit(:name)
    response.headers["Content-Type"] = "text/javascript"
    live_message("update")
  end
  
  def events
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    redis.psubscribe('messages.*') do |on|
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

  private

  def live_message(event)
    @message = Message.create(attributes)
    $redis.publish("messages.#{event}", @message.to_json)
  end  
end

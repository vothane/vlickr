require 'sinatra'
require 'erb'
require 'json'
require 'pry'
require 'sinatra/reloader' if development?

require_relative 'models/asset.rb'

get '/' do
  # app homepage
  images = get_images.values
  erb :layout, :locals => {images: images}
end

get '/images' do
  # get list of images
  images = get_images.values
  puts images.inspect
  content_type :json
  images.to_json
end

post '/images' do
  # create
  images = get_images

  image_data = JSON.parse(request.body.read.to_s)
  image = {
    url: image_data["url"],
    name: image_data["name"],
    description: image_data["description"]
  }

  id = (images.keys.max || 0)+1
  image[:id] = id
  images[id] = image

  content_type :json
  image.to_json
end

put '/images/:id' do
  # update
  id = params[:id].to_i

  images = get_images
  image = images[id]

  image_data = JSON.parse(request.body.read.to_s)
  image[:url] = image_data["url"]
  image[:name] = image_data["name"]
  image[:description] = image_data["description"]

  content_type :json
  image.to_json
end

delete '/images/:id' do
  #delete
  id = params[:id].to_i

  images = get_images
  images.delete(id)

  content_type :json
  {}.to_json
end

def get_images
  return settings.images if settings.respond_to?(:images)

  images = {};

  videos = Asset.find(:all) do |vid|
             vid.duration > 0
           end
  videos.each_with_index do |video, index|
      
    images[index] = {
      id: index,
      url: video.preview_image_url,
      name: video.name,
      description: video.description
    }

  end
 
  set :images, images
  return images
end


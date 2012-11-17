require 'sinatra'
require 'erb'
require 'json'
require 'sinatra/reloader' if development?

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
  images[1] = {
    id: 1,
    url: "http://ak.c.ooyala.com/84d2hxMzoDdGIIc1aciS20lsB3OMox0S/LHp2csp3BVpxnnKX5hMDoxOm1xO-1jSC",
    name: "The Force Volkswagen Commercial",
    description: "Darth Vader's iconic status has made the character a synonym for evil in popular culture."
  }
  images[2] = {
    id: 2,
    url: "http://ak.c.ooyala.com/dxZGdxMzomq2HVFWgXFDXnQ7hx5NpxJY/8Ru54IivvK7EGW8H5hMDoxOmdjOz0ndz",
    name: "Transformers 3 Dark of the Moon",
    description: "Cybertronian spacecraft carrying an invention capable of ending the war between the philanthropic Autobots and the malevolent Decepticons."
  }
  images[3] = {
    id: 3,
    url: "http://ak.c.ooyala.com/U3NmdxMzrJe_3B_8VLs1ZlrlIJfSID-9/2c0YxGwJFvMxVXlX5hMDoxOmFkO7UOTK",
    name: "Iron Sky",
    description: "Nazi's on the Moon."
  }
  images[4] = {
    id: 4,
    url: "http://ak.c.ooyala.com/o1NmdxMzrrWwbOVk_wIqhw-AmhlOMO49/j14TFkN_kLvndon35hMDoxOmFkO7UOTK",
    name: "Avengers",
    description: "Yeah, you know."
  }
 
  set :images, images
  return images
end


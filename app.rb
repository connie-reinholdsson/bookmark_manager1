ENV['RACK_ENV'] ||= 'development'


require 'sinatra/base'
require 'data_mapper'
require_relative './data_mapper_setup'
require_relative 'models/link'
require_relative 'models/tag'
require_relative 'models/user'

class Bookmark < Sinatra::Base
enable :sessions
set :session_secret, 'super secret'

  get '/' do
    erb(:index)
    redirect '/links'
  end

  get '/links' do
    session[:id] ||= 0
    @links = Link.all
    @tags = Tag.all
    erb(:links)
  end

  get '/links/new' do
    erb(:new_links)
  end

  post '/links' do
    link = Link.new(url: params[:url], name: params[:name])
    tags = params[:tags]
    tags = tags.split(", ")
    tags.each {|tag| link.tags << Tag.first_or_create(:name => tag)}
    link.save
    redirect '/links'
  end

  get '/links/:tag' do
    tag = Tag.first(:name => params[:tag])
    @links = tag.links
    erb:links
  end

  get '/user/new' do
    erb :user
  end

  post '/user' do
    user = User.create(email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect '/links'
  end


  helpers do
     def current_user
      User.get(session[:user_id])
     end
   end

end

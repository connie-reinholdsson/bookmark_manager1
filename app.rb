ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'data_mapper'
require 'sinatra/flash'
require_relative './data_mapper_setup'
require_relative 'models/link'
require_relative 'models/tag'
require_relative 'models/user'

class Bookmark < Sinatra::Base
enable :sessions
set :session_secret, 'super secret' # What? Did we need this?
register Sinatra::Flash

  get '/' do
    erb(:index)
    redirect '/links'
  end

  get '/links' do
    session[:id] ||= 0
    @links = Link.all # Puts all the instances of link in @links
    @tags = Tag.all
    erb(:links)
  end

  get '/links/new' do
    erb(:new_links)
  end

  post '/links' do
    link = Link.new(url: params[:url], name: params[:name]) # Name and URL
    tags = params[:tags] # tags equal tags (different)
    tags = tags.split(", ") # split the tags by comma
    tags.each {|tag| link.tags << Tag.first_or_create(:name => tag)}
    link.save
    redirect '/links'
  end

  get '/links/:tag' do
    tag = Tag.first(:name => params[:tag]) # Takes first tag in the database, from z
    @links = tag.links # Takes all the links from that tag
    erb:links
  end

  get '/user/new' do
    @user = User.new
    erb :user
  end

  post '/user' do
    @user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.save
    session[:user_id] = @user.id
      redirect '/links'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :user
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      sessions[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  helpers do
     def current_user
      User.get(session[:user_id])
     end

     def user_empty?
     !user.id
     end

   end

end

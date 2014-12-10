require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'
require 'pry'

require_relative 'config/application'

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/' do
  @meetups = Meetup.all.order("title ASC")
  erb :index
end

get '/meetup/:id' do
  @meetup = Meetup.find(params[:id])
  @users = @meetup.users
  @comments = @meetup.comments.order(:created_at)

  erb :show
end

post '/meetup/:id/add_comment' do
  authenticate!

  @user_id = current_user.id
  @meetup_id = params[:id]
  @title = params[:title]
  @body = params[:body]

  comment = Comment.create(user_id:  @user_id, meetup_id: @meetup_id, title: @title, body: @body)

  flash[:notice] = "Comment added!"

  redirect'/'
end

post '/meetup/:id/join' do
  @user_id = current_user.id
  @meetup_id = params[:id]

  Membership.create(user_id: @user_id, meetup_id: @meetup_id )

  flash[:notice] = "You've joined a meetup!"

  redirect'/'
end

post '/meetup/:id/leave' do
  authenticate!
  @user_id = current_user.id
  @meetup_id = params[:id]

  membership = Membership.find_by(user_id: @user_id, meetup_id: @meetup_id)

  membership.destroy

  flash[:notice] = "You've left this stupid meetup!"

  redirect'/'
end

get '/add_meetup' do
  erb :add_meetup
end

post '/add_meetup' do
  authenticate!
  title = params[:title]
  description = params[:description]
  location = params[:location]
  url = params[:url]

  meetup = Meetup.create(title: title, description: description, location: location, url: url)

  redirect "/meetup/#{meetup.id}"
end

get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end

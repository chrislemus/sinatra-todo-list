require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

  get "/" do  
    redirect "/users/#{Helpers.current_user(session).username}" if Helpers.logged_in?(session)
    erb :welcome
  end

  post('/login') {
    user = User.find_by(username: params[:username])    
    redirect '/' unless user && user.authenticate(params[:password])
    session[:user_id] = user.id
    session[:sort_due_date] = 'asc'
    session[:sort_completed] = false
    redirect "/users/#{user.username}"
  }

  get('/logout') {
    session.clear
    redirect '/'
  }

  get('/signup') {
    erb :signup
  }

  post('/signup') {
    params.each{ |k,v| redirect '/signup' if v.empty?}
    username_exist = User.find_by(username: params[:username])
    invalid_entry = !params[:username].match(/^[a-zA-Z0-9_]+$/) || !params[:password].match(/^[a-zA-Z0-9_]+$/)
    redirect '/signup' if  username_exist || invalid_entry
    user = User.create(username: params[:username], password: params[:password])
    session[:user_id] = user.id
    session[:sort_due_date] = 'asc'
    session[:sort_completed] = false
    redirect "/users/#{user.username}"
  }
end

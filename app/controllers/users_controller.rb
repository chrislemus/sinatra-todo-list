class UserController < ApplicationController

  get("/users/:username"){ 
    @user = Helpers.current_user(session)
    redirect '/' unless @user.username == params[:username]
    erb :'users/show'
  }
  


end
class UserController < ApplicationController

  get("/users/:username"){ 
    @user = Helpers.current_user(session)
    @tasks = @user.tasks.where('completed = ?', session[:sort_completed]).order("due_date #{session[:sort_due_date]}")
    @sort_due_date = session[:sort_due_date]  == 'asc' ? 'due date ⬆' : 'due date ⬇'
    @sort_completed = session[:sort_completed] ? 'completed ✓' : 'pending ⇌'
    # binding.pry
    redirect '/' unless @user.username == params[:username]
    erb :'users/show'
  }

  post('/user/sort/due-date') { 
    session[:sort_due_date] = session[:sort_due_date]  == 'asc' ? 'desc' : 'asc'
    redirect back
  }

  post('/user/sort/completed') { 
    session[:sort_completed] = session[:sort_completed]  == true ? false : true
    redirect back
  }
  
end
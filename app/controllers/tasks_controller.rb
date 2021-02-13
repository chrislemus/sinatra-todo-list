class TaskController < ApplicationController

  get("/tasks/new"){ 
    redirect '/' unless Helpers.logged_in?(session)
    user = Helpers.current_user(session)
    @categories = user.categories
    erb :'tasks/new'
  }

  post("/tasks/new"){ 
    redirect '/' unless Helpers.logged_in?(session)
    due_date = params[:due_date].empty? ? nil : params[:due_date]
    task = params[:task]
    redirect '/tasks/new' unless !task.empty?
    user = Helpers.current_user(session)
    category_id = params[:category] == 'nil' ? nil : params[:category].to_i
    Task.create(task: task, due_date: due_date, user_id: user.id, category_id: category_id, completed: false) 
    redirect "/users/#{user.username}"
  }

  patch('/tasks/:task_id/complete') {
    user = Helpers.current_user(session)
    task = user.tasks.find(params[:task_id])
    completed = task.completed ? false : true
    task.update(completed: completed)
    redirect "/users/#{user.username}"
  }

  get('/tasks/:task_id/edit') {
    user = Helpers.current_user(session)
    redirect '/' unless user
    @categories = user.categories
    @task = Task.find(params[:task_id])
    redirect '/' unless user.id == @task.user_id
    erb :'tasks/edit'
  }

  patch('/tasks/:task_id/edit') {
    task = Task.find(params[:task_id])
    user = Helpers.current_user(session)
    redirect "/tasks/#{task.id}/edit" unless !params[:task].empty? || user.id == task.user_id
    category_id = params[:category] == 'nil' ? nil : params[:category].to_i
    task.update(task: params[:task], due_date: params[:due_date], category_id: category_id)
    redirect "/users/#{user.username}"
  }
  delete('/tasks/:task_id') {
    task = Task.find(params[:task_id])
    user = Helpers.current_user(session)
    task.destroy if task.user_id == user.id
    redirect "/users/#{user.username}"
  }

end
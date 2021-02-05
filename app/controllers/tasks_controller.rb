class TaskController < ApplicationController

  get("/tasks/new"){ 
    redirect '/' unless Helpers.logged_in?(session)
    erb :'tasks/new'
  }

  post("/tasks/new"){ 
    redirect '/' unless Helpers.logged_in?(session)
    due_date = params[:due_date].empty? ? nil : params[:due_date]
    task = params[:task]
    redirect '/tasks/new' unless task
    user = Helpers.current_user(session)
    task = Task.create(task: task, due_date: due_date, user_id: user.id) 
    redirect "/users/#{user.username}"
  }

  patch('/tasks/:task_id/complete') {
    user = Helpers.current_user(session)
    task = user.tasks.find(params[:task_id])
    if task.date_completed
      task.update(date_completed: nil)
    else
      task.update(date_completed: Date.today.strftime('%Y/%m/%d'))
    end
    
    redirect "/users/#{user.username}"
  }

  get('/tasks/:task_id/edit') {
    @task = Task.find(params[:task_id])
    redirect '/' unless Helpers.current_user(session).id == @task.user_id
    erb :'tasks/edit'
  }

  patch('/tasks/:task_id/edit') {
    task = Task.find(params[:task_id])
    user = Helpers.current_user(session)
    redirect '/' unless user.id == task.user_id


    task.task = params[:task]
    task.due_date = params[:due_date]
    task.save
    
    redirect "/users/#{user.username}"
  }
  delete('/tasks/:task_id') {
    task = Task.find(params[:task_id])
    user = Helpers.current_user(session)
    task.destroy if task.user_id == user.id
    redirect "/users/#{user.username}"
  }

end
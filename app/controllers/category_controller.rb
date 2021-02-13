class CategoryController < ApplicationController

  get('/categories') {
    @categories = Helpers.current_user(session).categories
    erb :'categories/show'
  }

  patch('/categories/:category_id') {
    user = Helpers.current_user(session)
    category = Category.find(params[:category_id])
    new_name = params[:category_name]   
    category.update(name: new_name) if !new_name.empty? || category.user_id == user.id || category.name != new_name
    redirect '/categories' 
  }

  delete('/categories/:category_id') {
    user = Helpers.current_user(session)
    category = Category.find(params[:category_id])
    if category.user_id == user.id
      Task.where('category_id == ?', category.id).update_all(category_id: nil)
      category.destroy 
    end
    redirect '/categories' 
  }

  post('/categories') {
    user = Helpers.current_user(session)
    name = params[:category_name]
    Category.find_or_create_by(name: "#{name}", user_id: user.id) if !name.empty?
    redirect '/categories' 
  }

end
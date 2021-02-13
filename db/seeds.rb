User.destroy_all
Task.destroy_all
Category.destroy_all

user1 = User.create(username: 'chris', password: '123')
category_work = Category.create(name: 'work', user_id: user1.id)
category_school = Category.create(name: 'school', user_id: user1.id)
category_groceries = Category.create(name: 'groceries', user_id: user1.id)
Task.create(task: 'buy milk', user_id: user1.id, category_id: category_groceries.id, due_date: '2022/10/12', completed: true)
Task.create(task: 'buy cereal', user_id: user1.id, category_id: category_groceries.id, due_date: '2022/10/13', completed: true)
Task.create(task: 'submit algorithm project', user_id: user1.id, category_id: category_school.id, due_date: '2022/07/20')
Task.create(task: 'get presentation ready for investors📈', user_id: user1.id, category_id: category_work.id, due_date: '2022/11/17')
Task.create(task: 'buy new pc', user_id: user1.id )



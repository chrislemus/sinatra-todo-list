User.destroy_all
Task.destroy_all

user = User.create(username: 'me', password: '123')
Task.create(task: 'buy milk', user_id: user.id)
# t.string :task
# t.date :due_date
# t.integer :user_id
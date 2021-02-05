class CreateTodos < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :task
      t.date :due_date
      t.date :date_completed
      t.integer :user_id
    end
  end
end

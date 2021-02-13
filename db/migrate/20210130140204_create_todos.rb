class CreateTodos < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :task
      t.date :due_date
      t.boolean :completed, default: false
      t.integer :user_id
      t.integer :category_id
    end
  end
end

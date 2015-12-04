class CreateImplementTasks < ActiveRecord::Migration
  def change
    create_table :implement_tasks do |t|
      t.integer :task_id
      t.integer :task_item_id
      t.integer :pdsf_id
      t.timestamps null: false
    end
  end
end

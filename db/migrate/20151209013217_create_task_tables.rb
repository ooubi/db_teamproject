class CreateTaskTables < ActiveRecord::Migration
  def change
    create_table(:task_tables, :id => false) do |t|
      t.primary_key :task_item_id
      t.string :item
      t.integer :user_id
      t.string :user_name
      t.timestamps null: false
    end
  end
end

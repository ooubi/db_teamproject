class CreateTaskItems < ActiveRecord::Migration
  def change
    create_table(:task_items, :id => false) do |t|
      t.primary_key :task_item_id
      t.string :item
      t.timestamps null: false
    end
  end
end

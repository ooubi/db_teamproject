class CreateTasks < ActiveRecord::Migration
  def change
    create_table(:tasks, :id => false) do |t|
      t.primary_key :task_id
      t.string :task_name
      t.string :description, default: ''
      t.integer :min_upload_period_hour, default: 24
      t.string :tdt_name
      t.string :tdt_schema_info
      t.timestamps null: false
    end
  end
end

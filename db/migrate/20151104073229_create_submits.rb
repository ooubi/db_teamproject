class CreateSubmits < ActiveRecord::Migration
  def change
    create_table(:submits, :id => false) do |t|
      t.string :submit_user_id
      t.string :odt_id
      t.string :task_id
      t.timestamps null: false
    end
  end
end

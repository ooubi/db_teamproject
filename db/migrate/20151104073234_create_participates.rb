class CreateParticipates < ActiveRecord::Migration
  def change
    create_table(:participates, :id => false) do |t|
      t.integer :submit_user_id
      t.integer :task_id
      t.boolean :is_pending
      t.boolean :is_permitted
      t.timestamps null: false
    end
  end
end

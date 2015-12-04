class CreateParticipates < ActiveRecord::Migration
  def change
    create_table :participates do |t|
      t.integer :user_id
      t.integer :task_id
      t.boolean :is_pending, default: true
      t.boolean :is_permitted, default: false
      t.timestamps null: false
    end
  end
end

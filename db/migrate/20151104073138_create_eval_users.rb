class CreateEvalUsers < ActiveRecord::Migration
  def change
    create_table(:eval_users, :id => false) do |t|
      t.primary_key :eval_user_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end

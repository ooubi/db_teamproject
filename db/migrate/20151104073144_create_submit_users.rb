class CreateSubmitUsers < ActiveRecord::Migration
  def change
    create_table(:submit_users, :id => false) do |t|
      t.primary_key :submit_user_id
      t.integer :user_id
      t.integer :eval_value, default: 50
      t.timestamps null: false
    end
  end
end

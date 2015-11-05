class CreateSubmitUsers < ActiveRecord::Migration
  def change
    create_table(:submit_users, :id => false) do |t|
      t.string :user_id
      t.integer :eval_value, default: 50
      t.string :participate_id
      t.string :submit_id
      t.timestamps null: false
    end
  end
end

class CreateEvalUsers < ActiveRecord::Migration
  def change
    create_table(:eval_users, :id => false) do |t|
      t.primary_key :user_id
      t.string :pdst_id
      t.timestamps null: false
    end
  end
end

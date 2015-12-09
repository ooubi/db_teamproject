class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table(:admin_users, :id => false) do |t|
      t.primary_key :admin_user_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end

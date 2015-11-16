class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users, :id => false) do |t|
      t.primary_key :user_id
      t.string :login_id
      t.string :password
      t.string :name
      t.string :sex
      t.string :address, default: ''
      t.date :birthdate
      t.string :cellphone
      t.boolean :is_admin, default: false
      t.boolean :is_eval, default: false
      t.boolean :is_submit, default: false
      t.timestamps null: false
    end
  end
end

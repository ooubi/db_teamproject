class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users, :id => false) do |t|
      t.string :user_id
      t.string :login_id
      t.string :password
      t.string :name
      t.string :sex
      t.string :address, default: ''
      t.date :birthdate
      t.string :cellphone
      t.string :user_type
      t.timestamps null: false
    end
  end
end

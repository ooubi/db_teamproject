class CreateSubmits < ActiveRecord::Migration
  def change
    create_table :submits do |t|
      t.integer :submit_user_id
      t.integer :odf_id
      t.timestamps null: false
    end
  end
end

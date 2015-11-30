class CreateGeneralizes < ActiveRecord::Migration
  def change
    create_table :generalizes do |t|
      t.integer :odt_id
      t.integer :pdst_id
      t.timestamps null: false
    end
  end
end

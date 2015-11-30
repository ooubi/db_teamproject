class CreateImplementOdts < ActiveRecord::Migration
  def change
    create_table :implement_odts do |t|
      t.integer :odt_id
      t.integer :odf_id
      t.timestamps null: false
    end
  end
end

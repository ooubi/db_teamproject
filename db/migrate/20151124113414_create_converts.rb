class CreateConverts < ActiveRecord::Migration
  def change
    create_table(:converts, :id => false) do |t|
      t.integer :odf_id
      t.integer :pdsf_id
      t.timestamps null: false
    end
  end
end

class CreateImplementPdsts < ActiveRecord::Migration
  def change
    create_table(:implement_pdsts, :id => false) do |t|
      t.integer :pdst_id
      t.integer :pdsf_id
      t.timestamps null: false
    end
  end
end

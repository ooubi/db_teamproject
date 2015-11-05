class CreateOriginalDataTypes < ActiveRecord::Migration
  def change
    create_table(:original_data_types, :id => false) do |t|
      t.string :odt_id
      t.string :schema_info, default: ''
      t.string :mapping_info, default: ''
      t.string :submit_id
      t.string :pdst_id
      t.timestamps null: false
    end
  end
end

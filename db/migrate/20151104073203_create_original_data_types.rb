class CreateOriginalDataTypes < ActiveRecord::Migration
  def change
    create_table(:original_data_types, :id => false) do |t|
      t.primary_key :odt_id
      t.string :odt_name, default: ''
      t.string :schema_info, default: ''
      t.string :mapping_info, default: ''
      t.timestamps null: false
    end
  end
end

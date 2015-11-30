class CreateOriginalDataFiles < ActiveRecord::Migration
  def change
    create_table(:original_data_files, :id => false) do |t|
      t.primary_key :odf_id
      t.binary :file,	:null => false
      t.timestamps null: false
    end
  end
end

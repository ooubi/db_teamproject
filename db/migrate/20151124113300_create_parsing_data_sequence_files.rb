class CreateParsingDataSequenceFiles < ActiveRecord::Migration
  def change
    create_table(:parsing_data_sequence_files, :id => false) do |t|
      t.primary_key :pdsf_id
      t.string :file_url
      t.timestamps null: false
    end
  end
end

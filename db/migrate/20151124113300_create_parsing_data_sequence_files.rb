class CreateParsingDataSequenceFiles < ActiveRecord::Migration
  def change
    create_table(:parsing_data_sequence_files, :id => false) do |t|
      t.primary_key :pdsf_id
      t.string :file
      t.integer :season_info, default: 1
      t.string :null_ratio, default: '[]'
      t.integer :period_info, default: 1
      t.integer :estimate_state, default: 0
      t.integer :total_tuple_num, default: 0
      t.integer :dup_tuple_num, default: 0
      t.boolean :is_assigned, default: false
      t.boolean :is_evaluated, default: false
      t.boolean :is_passed, default: false
      t.integer :score, default: 5
      t.timestamps null: false
    end
  end
end

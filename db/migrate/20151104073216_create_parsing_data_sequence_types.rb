class CreateParsingDataSequenceTypes < ActiveRecord::Migration
  def change
    create_table(:parsing_data_sequence_types, :id => false) do |t|
      t.string :pdst_id
      t.string :task_name
      t.string :submit_user_id
      t.string :season_info
      t.float :null_ratio, default: 0.5
      t.string :period_info
      t.integer :estimate_state
      t.integer :total_tuple_num, default: 0
      t.integer :dup_tuple_num, default: 0
      t.string :odt_id
      t.string :eval_user_id
      t.timestamps null: false
    end
  end
end

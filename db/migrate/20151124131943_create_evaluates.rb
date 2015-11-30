class CreateEvaluates < ActiveRecord::Migration
  def change
    create_table :evaluates do |t|
      t.integer :eval_user_id
      t.integer :pdsf_id
      t.boolean :is_pending, default: true
      t.timestamps null: false
    end
  end
end

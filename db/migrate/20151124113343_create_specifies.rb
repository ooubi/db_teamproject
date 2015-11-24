class CreateSpecifies < ActiveRecord::Migration
  def change
    create_table(:specifies, :id => false) do |t|
      t.integer :odt_id
      t.integer :task_id
      t.timestamps null: false
    end
  end
end

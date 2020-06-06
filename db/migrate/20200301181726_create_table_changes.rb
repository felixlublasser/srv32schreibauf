class CreateTableChanges < ActiveRecord::Migration[5.2]
  def up
    create_table :table_changes do |t|
      t.integer :series_id, foreign_key: true, index: true, null: false
      t.integer :table_id, foreign_key: true, index: true, null: false
      t.integer :event_index, null: false
    end

    add_index :table_changes, [:series_id, :event_index], unique: true
  end

  def down
    drop_table :table_changes
  end
end

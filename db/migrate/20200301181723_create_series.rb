class CreateSeries < ActiveRecord::Migration[5.2]
  def up
    create_table :series do |t|
      t.integer :table_size, null: false, default: 3
      t.boolean :closed, null: false, default: false
      t.boolean :counts_ramsch, null: false, default: false
      t.boolean :negative_notation, null: false, default: false
      t.date :date, null: false

      t.string :notes

      t.timestamps null: false
    end
  end

  def down
    drop_table :series
  end
end

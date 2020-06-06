class CreateTables < ActiveRecord::Migration[5.2]
  def up
    create_table :tables do |t|
      t.integer :size
      t.integer :player_1_id, foreign_key: true, table_name: :players
      t.integer :player_2_id, foreign_key: true, table_name: :players
      t.integer :player_3_id, foreign_key: true, table_name: :players
      t.integer :player_4_id, foreign_key: true, table_name: :players
      t.integer :player_5_id, foreign_key: true, table_name: :players
    end

    add_index :tables, :player_1_id
    add_index :tables, :player_2_id
    add_index :tables, :player_3_id
    add_index :tables, :player_4_id
    add_index :tables, :player_5_id

    add_index :tables, [:size, :player_1_id, :player_2_id, :player_3_id, :player_4_id, :player_5_id], unique: true, name: 'unique_tables'

    execute <<-SQL
      ALTER TABLE tables
        ADD CONSTRAINT size_must_be_between_3_and_5
          CHECK ((size <= 5) AND (size >= 3));
    SQL

    execute <<-SQL
      ALTER TABLE tables
        ADD CONSTRAINT number_of_players_must_not_exceed_table_size
          CHECK ((size = 3 AND player_4_id IS NULL AND player_5_id IS NULL)
            OR (size = 4 AND player_5_id IS NULL)
            OR (size = 5));
    SQL

    execute <<-SQL
      ALTER TABLE tables
        ADD CONSTRAINT no_same_players
          CHECK ((player_2_id IS NULL
              OR (player_1_id != player_2_id))
            AND (player_3_id IS NULL
              OR (player_1_id != player_3_id)
              OR (player_2_id != player_3_id))
            AND (player_4_id IS NULL
              OR (player_1_id != player_4_id)
              OR (player_2_id != player_4_id)
              OR (player_3_id != player_4_id))
            AND (player_5_id IS NULL
              OR (player_1_id != player_5_id)
              OR (player_2_id != player_5_id)
              OR (player_3_id != player_5_id)
              OR (player_4_id != player_5_id)));
    SQL
  end

  def down
    drop_table :tables
  end
end

class CreateGames < ActiveRecord::Migration[5.2]
  def up
    create_table :games do |t|
      t.belongs_to :series, foreign_key: true, index: true, null: false
      t.integer :event_index, null: false
      t.belongs_to :table, foreign_key: true, null: false

      t.integer :value, null: false
      t.boolean :bock, null: false, default: false
      t.boolean :counts_towards_total, null: false, default: true
      t.boolean :needs_repeat, null: false, default: false

      t.string :game_type, null: false
      t.belongs_to :regular_game, foreign_key: true, index: true
      t.belongs_to :ramsch_game, foreign_key: true, index: true

      t.integer :seat_1_player_index, null: false
      t.integer :seat_2_player_index, null: false
      t.integer :seat_3_player_index, null: false

      t.string :notes

      t.timestamps null: false
    end

    execute <<-SQL
      ALTER TABLE games
        ADD CONSTRAINT at_most_one_set_of_details
          CHECK ((regular_game_id IS NULL) OR (ramsch_game_id IS NULL));
    SQL

    execute <<-SQL
      ALTER TABLE games
        ADD CONSTRAINT player_indices_max_of_5
          CHECK ((seat_1_player_index <= 5)
            AND (seat_2_player_index <= 5)
            AND (seat_3_player_index <= 5));
    SQL

    execute <<-SQL
      ALTER TABLE games
        ADD CONSTRAINT no_same_players
          CHECK ((seat_1_player_index != seat_2_player_index)
            AND (seat_1_player_index != seat_3_player_index)
            AND (seat_2_player_index != seat_3_player_index));
    SQL

    add_index :games, [:series_id, :event_index], unique: true
  end

  def down
    drop_table :games
  end
end

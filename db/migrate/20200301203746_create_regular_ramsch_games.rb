class CreateRegularRamschGames < ActiveRecord::Migration[5.2]
  def up
    create_table :regular_ramsch_games do |t|
      t.integer :jungfrau_seat, default: nil
      t.integer :point_receiver_two_seat, default: nil
      t.integer :point_receiver_three_seat, default: nil
      t.integer :receiver_of_last_trick_seat
      t.integer :points_achieved, null: false
    end

    execute <<-SQL
      ALTER TABLE regular_ramsch_games
        ADD CONSTRAINT seats_must_be_different
          CHECK (point_receiver_two_seat != point_receiver_three_seat);
    SQL

    execute <<-SQL
      ALTER TABLE regular_ramsch_games
        ADD CONSTRAINT jungfrau_must_not_be_point_receiver
          CHECK ((point_receiver_two_seat != jungfrau_seat)
          AND (point_receiver_three_seat != jungfrau_seat));
    SQL
  end

  def down
    drop_table :regular_ramsch_games
  end
end

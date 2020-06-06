class CreateRamschGames < ActiveRecord::Migration[5.2]
  def up
    create_table :ramsch_games do |t|
      t.boolean :first_seat_passed_on, null: false, default: false
      t.boolean :second_seat_passed_on, null: false, default: false
      t.boolean :third_seat_passed_on, null: false, default: false
      t.integer :point_receiver_seat, null: false

      t.belongs_to :regular_ramsch_game, foreign_key: true, index: true
    end
  end

  def down
    drop_table :ramsch_games
  end
end

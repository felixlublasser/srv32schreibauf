class CreateRegularGames < ActiveRecord::Migration[5.2]
  def change
    create_table :regular_games do |t|
    	t.integer :declarer_seat, null: false
    	t.integer :counters, null: false, default: 0
    	t.boolean :hand, null: false, default: false
    	t.boolean :ouvert, null: false, default: false
    	t.integer :game_value, null: false
    	t.boolean :won, null: false

    	t.belongs_to :suit_or_grand_game, foreign_key: true, index: true
    end
  end
end

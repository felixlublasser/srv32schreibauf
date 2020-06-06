class CreateSuitOrGrandGames < ActiveRecord::Migration[5.2]
  def change
    create_table :suit_or_grand_games do |t|
    	t.integer :base_value, null: false
    	t.integer :straight_trumps, null: false
    	t.boolean :with_old_one, null: false
    	t.integer :declared_point_levels, null: false, default: 0
    	t.integer :additional_point_levels, null: false
        t.boolean :spaltarsch, null: false, default: false
    	t.integer :bidding_value
    end
  end
end

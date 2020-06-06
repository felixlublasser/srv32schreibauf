class CreatePlayers < ActiveRecord::Migration[5.2]
  def up
    create_table :players do |t|
    	t.string :name, null: false
    end

    add_index :players, :name, unique: true
  end

  def down
    drop_table :players
  end
end

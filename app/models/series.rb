class Series < ApplicationRecord
	has_many :games, -> { order(:event_index) }, dependent: :destroy
	has_many :table_changes, -> { order(:event_index) }
	has_one :latest_table_change, -> { order('event_index DESC').limit(1) }, class_name: 'TableChange'
	has_one :current_table, through: :latest_table_change, class_name: 'Table', source: :table

	attr_accessor :player_ids

	before_create :setup_table
	before_update :change_table

	def setup_table
    table = Table.from_player_ids(player_ids.present? ? player_ids.first(table_size) : [nil]*table_size)
    table_changes.build(table: table, event_index: next_event_index)
  end

  def change_table
  	return if (!player_ids || player_ids.first(table_size) == current_table.player_ids)
  	table = Table.from_player_ids(player_ids.first(table_size))
  	if sorted_events.last.event_index == table_changes.last.event_index
  		table_changes.last.update!(table: table)
  	else
  		table_changes.build(table: table, event_index: next_event_index)
  	end
  end

	def build_game(game_attributes, player_ids = nil)
		atts = game_attributes.merge(event_index: next_event_index, player_ids: player_ids || current_table.player_ids )
		p atts
		games.build(atts)
	end

  def max_game_event_index
    games.last && games.last.event_index
  end

	def next_event_index
		(max_event_index && (max_event_index + 1)) || 0
	end

  def number_of_games
    games.length
  end

	private

  def max_event_index
    sorted_events.last&.event_index
  end

	def sorted_events
		[games, table_changes].flatten.sort_by{ |event| event.event_index }
	end
end

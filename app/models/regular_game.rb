class RegularGame < ApplicationRecord
	# has_one :game
	belongs_to :suit_or_grand_game, optional: true

	accepts_nested_attributes_for :suit_or_grand_game
	delegate_missing_to :suit_or_grand_game

	validates :declarer_seat, numericality: { greater_than_or_equal_to: 0, less_or_equal_than: 2 }
	validates :game_value, numericality: { greater_than_or_equal_to: 18 }

	# ATTRIBUTES

	# declarer_seat: integer in 0, 1, 2

	# counters
	  # 0   no counter
	  # 1   kontra
	  # 2   re
	  # 3   bock
	  # 4   hirsch
	  # ...

	# hand: bool

	# ouvert: bool

	# game_value: integer >= 18
	  # game value before adding possible multipliers for having lost (-2), Bock rounds (2) or counters
	  # but including modifiers from having achieved Schneider/Schwarz

	# won: bool
end

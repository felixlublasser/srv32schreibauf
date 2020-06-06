class SuitOrGrandGame < ApplicationRecord
	has_one :regular_game

	validates :base_value, inclusion: { in: [9, 10, 11, 12, 24] }
	validates :straight_trumps, numericality: { greater_than: 0, less_than: 12 }
	validates :declared_point_levels, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 2 }
	validates :additional_point_levels, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 2 }
	validates :bidding_value, numericality: { greater_than_or_equal_to: 18 }, allow_nil: true
	validate :spaltarsch_must_be_lost
	validate :spaltarsch_must_not_occur_with_point_levels_declared
	validate :spaltarsch_must_not_occur_with_additional_point_levels_achieved
	validate :point_levels_must_not_exceed_two

	def spaltarsch_must_be_lost
		if spaltarsch && regular_game.won
			errors.add :spaltarsch, 'spaltarsch is only possible in a lost game'
		end
	end

	def spaltarsch_must_not_occur_with_point_levels_declared
		if spaltarsch && (declared_point_levels != 0)
			errors.add :spaltarsch, 'spaltarsch is only possible without point level declarations'
		end
	end

	def spaltarsch_must_not_occur_with_additional_point_levels_achieved
		if spaltarsch && (additional_point_levels != 0)
			errors.add :spaltarsch, 'spaltarsch is only possible when no additional point levels were achieved'
		end
	end

	def point_levels_must_not_exceed_two
		if (declared_point_levels + additional_point_levels) > 2
			errors.add :spaltarsch, 'the sum of point levels must not exceed 2'
		end
	end

	# ATTRIBUTES

	# base_value:
		# 9   diamonds
		# 10  hearts
		# 11  spades
		# 12  clubs
		# 24  grand

	# straight_trumps: integers 1 to 11

	# with_old_one: bool
	  # whether the declarer possessed the jack of clubs

	# bidding_value: integer >= 18

	# declared_point_levels:
		# 0   nothing declared
		# 1   schneider declared
		# 2   schwarz declared

	# additional_point_levels:
		# 0   lost or won as declared
		# 1   one additional point level ((eigen)schneider if nothing declared OR (eigen)schwarz if schneider declared)
		# 2   two additional point levels ((eigen)schwarz if nothing declared)
end

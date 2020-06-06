class RamschGame < ApplicationRecord
	# has_one :game

	belongs_to :regular_ramsch_game, optional: true

	validates :point_receiver_seat, numericality: { greater_than_or_equal_to: 0, less_or_equal_than: 2 }

	accepts_nested_attributes_for :regular_ramsch_game
	delegate_missing_to :regular_ramsch_game

	# ATTRIBUTES

	# first_seat_passed_on: bool
	# second_seat_passed_on: bool
	# third_seat_passed_on: bool

	# point_receiver_seat: integer in 0, 1, 2
end

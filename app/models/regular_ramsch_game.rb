class RegularRamschGame < ApplicationRecord
  has_one :ramsch_game

  validates :jungfrau_seat, numericality: { greater_than_or_equal_to: 0, less_or_equal_than: 2 }, allow_nil: true
  validates :point_receiver_two_seat, numericality: { greater_than_or_equal_to: 0, less_or_equal_than: 2 }, allow_nil: true
  validates :point_receiver_three_seat, numericality: { greater_than_or_equal_to: 0, less_or_equal_than: 2 }, allow_nil: true
  validates :receiver_of_last_trick_seat, numericality: { greater_than_or_equal_to: 0, less_or_equal_than: 2 }, allow_nil: true
  validates :points_achieved, numericality: { greater_than_or_equal_to: 40, less_or_equal_than: 120 }
  validate :jungfrau_cannot_receive_points
  validate :point_receivers_must_all_be_different

  def point_receivers_must_all_be_different
    if (point_receiver_two_seat == ramsch_game.point_receiver_seat) || (point_receiver_three_seat == ramsch_game.point_receiver_seat)
      errors.add :jungfrau_seat, 'point receiver seat indices must all be different'
    end
  end

  def jungfrau_cannot_receive_points
    if jungfrau_seat && [ramsch_game.point_receiver_seat, point_receiver_two_seat, point_receiver_three_seat].include?(jungfrau_seat)
      errors.add :jungfrau_seat, 'jungfrau cannot receive points'
    end
  end

  # ATTRIBUTES

  # jungfrau_seat: integer in 0, 1, 2

  # point_receiver_two_seat: integer in 0, 1, 2
  # point_receiver_three_seat: integer in 0, 1, 2
    # if two or more players are matched on the highest amount of card points received, they all lose

  # receiver_of_last_trick_seat: integer in 0, 1, 2

  # points_achieved: 120 >= integer >= 40
    # only the card points, before applying any multipliers
end

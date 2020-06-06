class GameSerializer < ActiveModel::Serializer
  attributes :id,
	  :event_index,
	  :value,
	  :game_type,
	  :bock,
	  :notes,
    :counts_towards_total,
    :needs_repeat,
    :seat_1_player_index,
    :seat_2_player_index,
    :seat_3_player_index,
    :table

	attribute :declarer_seat, if: -> { regular? }
	attribute :counters, if: -> { regular? }
	attribute :hand, if: -> { regular? }
	attribute :ouvert, if: -> { regular? }
	attribute :game_value, if: -> { regular? }
	attribute :won, if: -> { regular? }

	attribute :base_value, if: -> { suit_or_grand? }
	attribute :straight_trumps, if: -> { suit_or_grand? }
	attribute :with_old_one, if: -> { suit_or_grand? }
	attribute :declared_point_levels, if: -> { suit_or_grand? }
	attribute :additional_point_levels, if: -> { suit_or_grand? }
  attribute :spaltarsch, if: -> { suit_or_grand? }
	attribute :bidding_value, if: -> { suit_or_grand? }

  attribute :first_seat_passed_on, if: -> { ramsch? }
  attribute :second_seat_passed_on, if: -> { ramsch? }
  attribute :third_seat_passed_on, if: -> { ramsch? }
  attribute :point_receiver_seat, if: -> { ramsch? }

	attribute :jungfrau_seat, if: -> { regular_ramsch? }
  attribute :point_receiver_two_seat, if: -> { regular_ramsch? }
  attribute :point_receiver_three_seat, if: -> { regular_ramsch? }
  attribute :receiver_of_last_trick_seat, if: -> { regular_ramsch? }
  attribute :points_achieved, if: -> { regular_ramsch? }

  delegate :regular?, :ramsch?, :regular_ramsch?, :suit_or_grand?, to: :object

  def table
    object.table.players.map do |player|
      player ? PlayerSerializer.new(player) : nil
    end
  end
end

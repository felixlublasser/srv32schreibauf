class GamesController < ApplicationController
	def create
		game = series.build_game(game_attributes)
		game.save!
		render json: series.games
	end

	def update
		Game.find(params[:id]).update_attributes!(game_attributes)
		render json: series.games
	end

	def index
		render json: series.games
	end

	private

	def series
		Series.find(params[:series_id])
	end

	def game_attributes
		case params[:game_type].to_sym
		when :null
			game_base_params.merge(regular_game_attributes: regular_game_params)
		when :suit_or_grand
			game_base_params.merge(regular_game_attributes:
				regular_game_params.merge(suit_or_grand_game_attributes: suit_or_grand_params)
			)
		when :ramsch
			game_base_params.merge(ramsch_game_attributes:
				ramsch_params.merge(regular_ramsch_game_attributes: regular_ramsch_params)
			)
		when :durchmarsch
			game_base_params.merge(ramsch_game_attributes: ramsch_params)
		when :pass_out
			game_base_params
		end
	end

	def game_base_params
		params.permit(
			:value,
			:bock,
			:notes,
			:game_type,
			:counts_towards_total,
			:needs_repeat,
			:player_ids,
			:seat_1_player_index,
			:seat_2_player_index,
			:seat_3_player_index
		)
	end

	def regular_game_params
		params.permit(
			:declarer_seat,
			:counters,
			:hand,
			:ouvert,
			:game_value,
			:won
		)
	end

	def suit_or_grand_params
		params.permit(
			:base_value,
			:straight_trumps,
			:with_old_one,
			:declared_point_levels,
			:additional_point_levels,
			:spaltarsch,
			:bidding_value
		)
	end

	def ramsch_params
		params.permit(
    	:first_seat_passed_on,
    	:second_seat_passed_on,
    	:third_seat_passed_on,
    	:point_receiver_seat
		)
	end

	def regular_ramsch_params
		params.permit(
			:jungfrau_seat,
    	:point_receiver_two_seat,
    	:point_receiver_three_seat,
    	:receiver_of_last_trick_seat,
    	:points_achieved
		)
	end
end

class SeriesController < ApplicationController
	def show
		render json: series
	end

	def create
		newSeries = Series.new(series_params)
		newSeries.player_ids = player_ids
		newSeries.save!
		render json: newSeries
	end

	def index
		render_series_list
	end

	def update
		series.assign_attributes(series_params)
		series.player_ids = player_ids
		series.save!
		render json: series
	end

	def destroy
		series.delete
		render_series_list
	end

	private

	def render_series_list
		render json: Series.all.order('date DESC'), each_serializer: SeriesSerializer
	end

	def series
		@series ||= Series.find(params[:id])
	end

	def series_params
		params
			.require(:series)
			.permit(
	    	:closed,
	    	:counts_ramsch,
				:date,
	    	:negative_notation,
	    	:notes,
				:table_size,
	    	player_ids: [:'0', :'1', :'2', :'3', :'4']
	    )
	end

	def player_ids
		params.permit(player_ids: [:'0', :'1', :'2', :'3', :'4']).values.first.values
	end
end

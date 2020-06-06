class PlayersController < ApplicationController
  def index
    render json: Player.all.order(:name)
  end

  def show
    player = Player.find_by(name: params[:id])
    if player
      render json: player
    else
      render json: {}, status: :not_found
    end
  end

  def create
    Player.create!(player_params)
    render json: Player.all.order(:name)
  end

  private

  def player_params
    params.permit(:name)
  end
end

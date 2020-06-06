class Game < ApplicationRecord
  # Game Types
  GAME_TYPE_SUIT_OR_GRAND = :suit_or_grand
  GAME_TYPE_NULL = :null
  GAME_TYPE_REGULAR_RAMSCH = :ramsch
  GAME_TYPE_DURCHMARSCH = :durchmarsch
  GAME_TYPE_PASS_OUT = :pass_out

  belongs_to :series
  belongs_to :regular_game, optional: true
  belongs_to :ramsch_game, optional: true
  belongs_to :table

  attr_accessor :player_ids

  accepts_nested_attributes_for :regular_game
  accepts_nested_attributes_for :ramsch_game

  delegate_missing_to :detail

  validates :event_index, numericality: { greater_or_equal_than: 0 }

  validates :game_type, inclusion: { in: [
    GAME_TYPE_SUIT_OR_GRAND,
    GAME_TYPE_NULL,
    GAME_TYPE_REGULAR_RAMSCH,
    GAME_TYPE_DURCHMARSCH,
    GAME_TYPE_PASS_OUT
  ].map(&:to_s) }

  before_validation :build_table

  def self.build(base_params:, detail_params:)
    new(base_params).tap do |game|
      game.build_detail(base_params[:game_type], detail_params)
    end
  end

  def build_table
    return unless player_ids.present?
    self.table = Table.from_player_ids(player_ids)
  end

  def regular?
    [GAME_TYPE_SUIT_OR_GRAND, GAME_TYPE_NULL].include? game_type_sym
  end

  def ramsch?
    [GAME_TYPE_REGULAR_RAMSCH, GAME_TYPE_DURCHMARSCH].include? game_type_sym
  end

  def regular_ramsch?
    game_type_sym == GAME_TYPE_REGULAR_RAMSCH
  end

  def suit_or_grand?
    game_type_sym == GAME_TYPE_SUIT_OR_GRAND
  end

  def player_indices
    [seat_1_player_index, seat_2_player_index, seat_3_player_index]
  end

  # def players
  #   player_indices.map{ |ix| table.players[ix] }
  # end

  private

  def detail
    regular_game || ramsch_game
  end

  def game_type_sym
    game_type.to_sym
  end

  # ATTRIBUTES

  # value: integer
    # game value after applying all multipliers
    # would be added to a player's total (or subtracted from the other players' total in neg notation)

  # event_index: integer > 0
    # denotes the order in which games of a series were played
    # must be consecutive

  # game_type: string
    # either 'null', 'suit_or_grand', or 'ramsch'

  # bock: bool

  # notes: string
end

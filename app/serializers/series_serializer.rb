class SeriesSerializer < ActiveModel::Serializer
  attributes :id,
    :date,
    :closed,
    :counts_ramsch,
    :negative_notation,
    :notes,
    :table_changes,
    :table_size,
    :max_game_event_index,
    :number_of_games

  def table_changes
    object.table_changes.map do |table_change|
      TableChangeSerializer.new(table_change)
    end
  end
end

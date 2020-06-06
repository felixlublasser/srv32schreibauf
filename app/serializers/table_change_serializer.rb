class TableChangeSerializer < ActiveModel::Serializer
  attributes :table,
    :event_index

  def table
    object.table.players.map do |player|
      player && PlayerSerializer.new(player)
    end
  end
end

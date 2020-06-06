class Table < ApplicationRecord
  belongs_to :player_1, class_name: 'Player', optional: true
  belongs_to :player_2, class_name: 'Player', optional: true
  belongs_to :player_3, class_name: 'Player', optional: true
  belongs_to :player_4, class_name: 'Player', optional: true
  belongs_to :player_5, class_name: 'Player', optional: true

  def self.from_player_ids(player_ids)
    find_or_create_by!(
      size: player_ids.length,
      player_1_id: player_ids[0],
      player_2_id: player_ids[1],
      player_3_id: player_ids[2],
      player_4_id: player_ids[3],
      player_5_id: player_ids[4]
    )
  end

  # def ==(other_player)
  #   (size == other_player.size) && (player_ids.join('.') == other_player.player_ids.join('.'))
  # end

  def players
    player_ids.map{ |id| id && Player.find(id) }
  end

  def player_ids
    [player_1_id, player_2_id, player_3_id, player_4_id, player_5_id].first(size)
  end
end

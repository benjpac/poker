class Round < ActiveRecord::Base
  has_many :cards
  has_many :hands, through: :cards

  def create_flop
    for i in 1..3
      random_card = Card.pull_random_card
      random_card.update(round_id: self.id)
    end
  end

  def create_turn
    random_card = Card.pull_random_card
    random_card.update(round_id: self.id)
  end

  def create_river
    random_card = Card.pull_random_card
    random_card.update(round_id: self.id)
  end

  def change_active_player(player_id)
    round.update(active_player_id: player.id)
  end

  def inactive_player_id
    active_player_id
    inactive_player = Player.all.where(round_id: self.id) - [Player.find(active_player_id)]
    return inactive_player.first.id
  end
end

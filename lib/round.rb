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
    inactive_players = self.players_in_game - [Player.find(self.active_player_id)]
    return inactive_players.first.id
  end

  def players_in_game
    players_in_game = []
    hands_in_game = Hand.all.where(round_id: self.id)
    hands_in_game.each {|hand| players_in_game.push(hand.player)}
    return players_in_game
  end
end

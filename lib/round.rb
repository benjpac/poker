class Round < ActiveRecord::Base
  has_many :cards
  has_many :hands

  def create_game (player1, player2, blind)
    Card.create_deck
    hand1 = Hand.create(bet: 0, player_id: player1.id, round_id: self.id)
    hand1.create_hand
    hand1.make_bet(blind)
    hand2 = Hand.create(bet: 0, player_id: player2.id, round_id: self.id)
    hand2.create_hand
    hand2.make_bet(blind*2)
    self.update(active_player_id: player1.id)
  end

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
    active_player = Player.find(self.active_player_id)
    return other_player_id(active_player)
  end

  def other_player_id(player)
    other_players = self.players_in_game - [player]
    return other_players.first.id
  end

  def players_in_game
    players_in_game = []
    hands_in_game = Hand.all.where(round_id: self.id)
    hands_in_game.each {|hand| players_in_game.push(hand.player)}
    return players_in_game
  end
end

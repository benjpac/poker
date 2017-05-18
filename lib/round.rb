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

  def deal_cards(current_bet)
    round = self
    last_two_bets = [round.last_bet, current_bet]
    if round.cards.length == 0
      if last_two_bets == ["call", "check"] || last_two_bets == ["check", "check"]
        round.update(last_bet: "")
        round.create_flop
        round.hands.each {|hand| hand.move_to_pot}
      else
        round.update(last_bet: current_bet)
      end
    elsif round.cards.length == 3 || round.cards.length == 4
      if last_two_bets == ["raise", "call"] || last_two_bets == ["check", "check"]
        round.update(last_bet: "")
        random_card = Card.pull_random_card
        random_card.update(round_id: round.id)
        round.hands.each {|hand| hand.move_to_pot}
      else
        round.update(last_bet: current_bet)
      end
    elsif round.cards.length == 5
      if last_two_bets == ["raise", "call"] || last_two_bets == ["check", "check"]
      round.update(last_bet: "")
      round = round.find_winner
    else
      round.update(last_bet: current_bet)
      end
    end
    return round
  end

  def find_winner
    hand1 = self.hands.first
    hand2 = self.hands.last
    winner = hand1.rank_hand <=> hand2.rank_hand
    if winner == 1
      new_round = hand1.win
    elsif winner == -1
      new_round = hand2.win
    elsif winner == 0
      new_round = hand1.tie
    end
    return new_round
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

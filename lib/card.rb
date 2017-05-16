class Card < ActiveRecord::Base
  belongs_to :hand
  belongs_to :flop

  @@deck = []

  class << self

    def shuffled_deck
      suits = ['s', 'd', 'c', 'h']
      suits.each do |suit|
        (2..14).each do |value|
          card = Card.create(suit: suit, value: value)
          @@deck.push(card)
        end
      end
      return @@deck.shuffle
    end

    def deal_card
      return @@deck.pop
    end

    def deal_to_players(num_players)
      player_hands = Array.new(num_players) {[]}
      for i in 0..num_players-1
        player_hands[i].push(Card.deal_card)
        player_hands[i].push(Card.deal_card)
      end
      return player_hands
    end

    def flop
      flop = []
      for i in 1..3
        flop.push(Card.deal_card)
      end
      return flop
    end

  end

end

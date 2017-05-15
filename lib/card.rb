class Card < ActiveRecord::Base
  belongs_to :hands
  belongs_to :flops

  def self.create_deck
    deck = []
    suits = ["s", "d", "c", "h"]
    suits.each do |suit|
      2..14.each do |value|
        card = Card.create(suit: suit, value: value)
        deck.push(card)
      end
    end
    return deck
  end

  #pick a random card(deck)

  #deal cards

  #add to flop

  #not_yet_dealt


end

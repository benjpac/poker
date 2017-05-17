class Card < ActiveRecord::Base
  belongs_to :hand
  belongs_to :round

  def create_deck
    suits = ['s', 'd', 'c', 'h']
    suits.each do |suit|
      (2..14).each do |value|
        card = Card.create(suit: suit, value: value, deck_id: self.id)
      end
    end
  end

  def remaining_cards
    return Card.all.where(round_id: nil, hand_id: nil)
  end

  def pull_random_card
    remaining_cards = Card.all.remaining_cards
    return remaining_cards.sample
  end

  def image_string
    suit = self.suit
    value = self.value.to_s
    return suit + "_" + value
  end

end

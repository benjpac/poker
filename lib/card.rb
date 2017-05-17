class Card < ActiveRecord::Base
  belongs_to :hand
  belongs_to :round

  class << self

    def create_deck
      Card.destroy_all
      suits = ['s', 'd', 'c', 'h']
      suits.each do |suit|
        (2..14).each do |value|
          Card.create(suit: suit, value: value)
        end
      end
    end

    def remaining_cards
      return Card.all.where(round_id: nil, hand_id: nil)
    end

    def pull_random_card
      remaining_cards = Card.remaining_cards
      return remaining_cards.sample
    end

  end

  def image_string
    suit = self.suit
    value = self.value.to_s
    return suit + "_" + value
  end

end

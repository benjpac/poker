class Deck < ActiveRecord::Base
  has_many :cards
  has_many :hands
  has_one :round
  # validates(:description, {:presence => true, :length => {:maximum => 50}})
  after_create(:create_deck)

  def create_deck
    suits = ['s', 'd', 'c', 'h']
    suits.each do |suit|
      (2..14).each do |value|
        card = Card.create(suit: suit, value: value, deck_id: self.id)
      end
    end
  end

  def remaining_cards
    return self.cards.where(round_id: nil, hand_id: nil)
  end

  def pull_random_card
    remaining_cards = self.remaining_cards
    return remaining_cards.sample
  end

end

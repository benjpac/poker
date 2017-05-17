class Round < ActiveRecord::Base
  has_many :cards
  has_many :hands, through: :cards
  after_create(:create_flop)

  def create_flop
    deck = self.deck
    for i in 1..3
      random_card = deck.pull_random_card
      random_card.update(round_id: self.id)
    end
  end

  def create_turn
    deck = self.deck
    random_card = deck.pull_random_card
    random_card.update(round_id: self.id)
  end

  def create_river
    deck = self.deck
    random_card = deck.pull_random_card
    random_card.update(round_id: self.id)
  end

end

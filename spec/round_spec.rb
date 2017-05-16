require 'spec_helper'

describe Round do
  it { should have_many(:cards) }
  it { should belong_to(:deck) }

  it 'returns 3 cards from deck and assigns round_id' do
    deck = Deck.create
    round = deck.create_round
    hand1 = deck.hands.create
    hand1.create_two_cards
    deck.round.create_turn
    deck.round.create_river
    # expect(deck.cards.where(round_id: round.id)).to all(include({"deck_id" => deck.id}))
  end
end

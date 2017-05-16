require 'spec_helper'

describe Round do
  it { should have_many(:cards) }
  it { should belong_to(:deck) }

  it 'returns 3 cards from deck and assigns round_id' do
    deck = Deck.create
    round = deck.create_round
    hand1 = deck.hands.create
    deck.round.create_turn
    deck.round.create_river
    test1 = hand1.add_round_id(round)
    binding.pry
    # expect(deck.cards.where(round_id: round.id)).to all(include({"deck_id" => deck.id}))
  end
end

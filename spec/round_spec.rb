require 'spec_helper'

describe Round do
  it { should have_many(:cards) }
  it { should have_many(:hands) }

  it 'creates a flop' do
    Card.create_deck
    round = Round.create
    round.create_flop
    expect(Card.all.where(round_id: round.id).length).to eq(3)
  end

  it 'creates a flop, turn, and river' do
    Card.create_deck
    round = Round.create
    round.create_flop
    round.create_turn
    round.create_river
    expect(Card.all.where(round_id: round.id).length).to eq(5)
  end

  it 'returns 3 cards from deck and assigns round_id' do
    # deck = Deck.create
    # round = deck.create_round
    # hand1 = deck.hands.create
    # hand1.create_two_cards
    # deck.round.create_turn
    # deck.round.create_river
    # expect(deck.cards.where(round_id: round.id)).to all(include({"deck_id" => deck.id}))
  end
end

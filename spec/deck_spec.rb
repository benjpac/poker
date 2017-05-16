require 'spec_helper'

describe Deck do
  it { should have_many(:cards) }
  it { should have_many(:hands) }
  it { should have_one(:round) }

  it 'creates a deck of cards' do
    deck = Deck.create
  end
  it 'returns cards that are not in a hand or a round (community cards)' do
    deck = Deck.create
    random_card = deck.pull_random_card
  end
end

require 'spec_helper'

describe Round do
  it { should have_many(:cards) }
  it { should belong_to(:deck) }

  it 'returns 3 cards from deck and assigns round_id' do
    deck = Deck.create
    round = deck.create_round
    binding.pry
  end
end

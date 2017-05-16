require 'spec_helper'

describe Card do
  it { should belong_to(:flop) }
  it { should belong_to(:hand) }
  # before() do
  #   @@deck = []
  # end
  #
  # it 'returns and removes cards from deck array' do
  #   @@deck = Card.shuffled_deck
  #   card = Card.deal_card
  #   expect(@@deck).not_to include(card)
  #   card1 = Card.deal_card
  #   expect(@@deck).not_to include(card1)
  # end
  # it 'simulate flop' do
  #   @@deck = Card.shuffled_deck
  #   flop = Card.flop
  #   expect(@@deck).not_to include(flop)
  # end
  # it 'simulate deal cards to 3 players with flop' do
  #   @@deck = Card.shuffled_deck
  #   player_hands = Card.deal_to_players(3)
  #   expect(@@deck).not_to include(player_hands)
  #   flop = Card.flop
  #   expect(@@deck).not_to include(flop)
  #   binding.pry
  # end
  # it 'simulate deal cards to 3 players with flop' do
  #   @@deck = Card.shuffled_deck
  #   flop = flop.cards
  #   binding.pry
  # end
end

# hand.cards

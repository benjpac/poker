require 'spec_helper'

describe Hand do
  it { should have_many(:cards) }

  it 'simulate deal cards to 3 players with flop' do
    @@deck = Card.shuffled_deck
    card = Card.deal_card
    hand = Hand.create

    card.update(hand_id: hand.id)
  end
end

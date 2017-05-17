require 'spec_helper'

describe Card do
  it { should belong_to(:round) }
  it { should belong_to(:hand) }

  it 'create a deck of 52 cards' do
    Card.create_deck
    expect(Card.all.length).to eq(52)
  end

  it 'returns cards not assigned to a hand or round (community cards)' do
    Card.create_deck
    expect(Card.remaining_cards.length).to eq(52)
  end

  it 'pulls random card from deck' do
    Card.create_deck
    expect(Card.pull_random_card).to be_a(Card)
  end

  # it "returns image strings from a flops card objects" do
  #   deck = Deck.create
  #   round = deck.create_round
  #   card_urls = []
  #   round.cards.each do |card|
  #     card_urls.push(card.image_string)
  #   end
  # end

end

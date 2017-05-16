require 'spec_helper'

describe Card do
  it { should belong_to(:round) }
  it { should belong_to(:hand) }
  it { should belong_to(:deck) }

  it "returns image strings from a flops card objects" do
    deck = Deck.create
    round = deck.create_round
    card_urls = []
    round.cards.each do |card|
      card_urls.push(card.image_string)
    end
  end

end

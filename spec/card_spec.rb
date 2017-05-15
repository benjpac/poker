require 'spec_helper'

describe Card do
  describe "create_deck" do
    it "creates a full deck" do
      deck = Card.create_deck
      expect(deck).to eq()
    end
  end

end

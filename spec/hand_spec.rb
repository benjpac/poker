require 'spec_helper'

describe Hand do
  it { should have_many(:cards) }

  it 'simulate deal cards to 3 players with round' do
    @@deck = Card.shuffled_deck
    card = Card.deal_card
    hand = Hand.create

    card.update(hand_id: hand.id)
  end

  describe "add_round_and_sort" do
    it "adds cards from the round to the hand and sorts cards by value" do
      hand = hand.create
      card1 = Card.create(suit: "s", value: 7, hand_id: hand.id)
      card2 = Card.create(suit: "c", value: 6, hand_id: hand.id)
      round = round.create
      card3 = Card.create(suit: "s", value: 5, round_id: round.id)
      card4 = Card.create(suit: "d", value: 4, round_id: round.id)
      card5 = Card.create(suit: "s", value: 3, round_id: round.id)
      card6 = Card.create(suit: "d", value: 14, round_id: round.id)
      card7 = Card.create(suit: "s", value: 9, round_id: round.id)
      expect(Hand.add_round_and_sort).to eq([card6, card7, card1, card2, card3, card4, card5])
    end
  end

  describe "get_five" do
    it "returns all combinations of five" do
      hand = hand.create
      card1 = Card.create(suit: "s", value: 7, hand_id: hand.id)
      card2 = Card.create(suit: "c", value: 6, hand_id: hand.id)
      round = round.create
      card3 = Card.create(suit: "s", value: 5, round_id: round.id)
      card4 = Card.create(suit: "d", value: 4, round_id: round.id)
      card5 = Card.create(suit: "s", value: 3, round_id: round.id)
      card6 = Card.create(suit: "d", value: 14, round_id: round.id)
      card7 = Card.create(suit: "s", value: 9, round_id: round.id)
      expect(Hand.combinations).to include([card6, card7, card3, card4, card5])
    end
    it "has length" do
      hand = hand.create
      card1 = Card.create(suit: "s", value: 7, hand_id: hand.id)
      card2 = Card.create(suit: "c", value: 6, hand_id: hand.id)
      round = round.create
      card3 = Card.create(suit: "s", value: 5, round_id: round.id)
      card4 = Card.create(suit: "d", value: 4, round_id: round.id)
      card5 = Card.create(suit: "s", value: 3, round_id: round.id)
      card6 = Card.create(suit: "d", value: 14, round_id: round.id)
      card7 = Card.create(suit: "s", value: 9, round_id: round.id)
      expect(Hand.combinations.length).to eq(42)
    end
  end

  describe "straight" do
    it "tests if five cards are a straight" do
      card1 = Card.create(suit: "s", value: 7)
      card2 = Card.create(suit: "c", value: 6)
      card3 = Card.create(suit: "s", value: 5)
      card4 = Card.create(suit: "d", value: 4)
      card5 = Card.create(suit: "s", value: 3)
      five = [card1, card2, card3, card4, card5]
      expect(Hand.straight(five)).to eq(7)
    end
    it "tests returns 0 if hand is not a straight" do
      card1 = Card.create(suit: "s", value: 7)
      card2 = Card.create(suit: "c", value: 12)
      card3 = Card.create(suit: "s", value: 5)
      card4 = Card.create(suit: "d", value: 4)
      card5 = Card.create(suit: "s", value: 3)
      five = [card1, card2, card3, card4, card5]
      expect(Hand.straight(five)).to eq(0)
    end
  end

  describe "flush" do
    it "tests if five cards are a flush" do
      card1 = Card.create(suit: "s", value: 7)
      card2 = Card.create(suit: "s", value: 8)
      card3 = Card.create(suit: "s", value: 5)
      card4 = Card.create(suit: "s", value: 4)
      card5 = Card.create(suit: "s", value: 3)
      five = [card1, card2, card3, card4, card5]
      expect(Hand.flush(five)).to eq(7)
    end
    it "tests returns 0 if hand is not a flush" do
      card1 = Card.create(suit: "s", value: 7)
      card2 = Card.create(suit: "c", value: 12)
      card3 = Card.create(suit: "s", value: 5)
      card4 = Card.create(suit: "d", value: 4)
      card5 = Card.create(suit: "s", value: 3)
      five = [card1, card2, card3, card4, card5]
      expect(Hand.flush(five)).to eq(0)
    end
  end

  describe "four_of_a_kind" do
    it "tests if five cards contain a four_of_a_kind" do
      card1 = Card.create(suit: "s", value: 7)
      card2 = Card.create(suit: "c", value: 7)
      card3 = Card.create(suit: "d", value: 7)
      card4 = Card.create(suit: "h", value: 7)
      card5 = Card.create(suit: "s", value: 3)
      five = [card1, card2, card3, card4, card5]
      expect(Hand.four_of_a_kind(five)).to eq(7)
    end
    it "tests returns 0 if hand does not contain four_of_a_kind" do
      card1 = Card.create(suit: "s", value: 7)
      card2 = Card.create(suit: "c", value: 12)
      card3 = Card.create(suit: "s", value: 5)
      card4 = Card.create(suit: "d", value: 4)
      card5 = Card.create(suit: "s", value: 3)
      five = [card1, card2, card3, card4, card5]
      expect(Hand.four_of_a_kind(five)).to eq(0)
    end
  end

  describe "three_of_a_kind" do
    it "tests if five cards contain a three_of_a_kind" do
      card1 = Card.create(suit: "s", value: 7)
      card2 = Card.create(suit: "c", value: 7)
      card3 = Card.create(suit: "d", value: 7)
      card4 = Card.create(suit: "h", value: 4)
      card5 = Card.create(suit: "s", value: 3)
      five = [card1, card2, card3, card4, card5]
      expect(Hand.three_of_a_kind(five)).to eq(7)
    end
    it "tests returns 0 if does not contain three_of_a_kind" do
      card1 = Card.create(suit: "s", value: 7)
      card2 = Card.create(suit: "c", value: 12)
      card3 = Card.create(suit: "s", value: 5)
      card4 = Card.create(suit: "d", value: 4)
      card5 = Card.create(suit: "s", value: 3)
      five = [card1, card2, card3, card4, card5]
      expect(Hand.three_of_a_kind(five)).to eq(0)
    end
  end

  describe "pair" do
    it "tests if five cards contains a pair" do
      card1 = Card.create(suit: "s", value: 7)
      card2 = Card.create(suit: "c", value: 5)
      card3 = Card.create(suit: "d", value: 7)
      card4 = Card.create(suit: "h", value: 4)
      card5 = Card.create(suit: "s", value: 3)
      five = [card1, card2, card3, card4, card5]
      expect(Hand.pair(five)).to eq(7)
    end

    it "tests if four cards contains a pair" do
      card1 = Card.create(suit: "s", value: 7)
      card2 = Card.create(suit: "c", value: 5)
      card3 = Card.create(suit: "d", value: 7)
      card4 = Card.create(suit: "h", value: 4)
      five = [card1, card2, card3, card4]
      expect(Hand.pair(five)).to eq(7)
    end

    it "tests returns 0 if hand does not contain a pair" do
      card1 = Card.create(suit: "s", value: 7)
      card2 = Card.create(suit: "c", value: 12)
      card3 = Card.create(suit: "s", value: 5)
      card4 = Card.create(suit: "d", value: 4)
      card5 = Card.create(suit: "s", value: 3)
      five = [card1, card2, card3, card4, card5]
      expect(Hand.four_of_a_kind(five)).to eq(0)
    end
  end
end

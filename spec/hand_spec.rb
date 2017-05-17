require 'spec_helper'

describe Hand do
  it { should have_many(:cards) }
  it { should belong_to(:player) }

  it 'creates a flop' do
    Card.create_deck
    hand = Hand.create
    hand.create_hand
    expect(Card.all.where(hand_id: hand.id).length).to eq(2)
  end

  it 'returns cards in hand and in round (community cards)' do
    Card.create_deck
    hand = Hand.create
    hand.create_hand
    round = Round.create
    round.create_flop
    round.create_turn
    round.create_river
    expect(hand.add_round_and_sort(round).length).to eq(7)
  end


  # it 'it creates a deck, a flop, 2 player cards, a turn, a river, and returns them' do
  #   deck = Deck.create
  #   round = deck.create_round
  #   hand1 = deck.hands.create
  #
  # end
  #

  # describe "rank_hand" do
  #   it "gives a rank of 90014 for a royal flush" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 13, round_id: round.id)
  #     card4 = Card.create(suit: "s", value: 12, round_id: round.id)
  #     card5 = Card.create(suit: "s", value: 11, round_id: round.id)
  #     card6 = Card.create(suit: "s", value: 14, round_id: round.id)
  #     card7 = Card.create(suit: "s", value: 10, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 7, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "s", value: 6, hand_id: hand.id, round_id: round.id)
  #     expect(hand.rank).to eq(90014))
  #   end
  #
  #   it "gives a rank of 900xx for a straight flush" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 13, round_id: round.id)
  #     card4 = Card.create(suit: "s", value: 12, round_id: round.id)
  #     card5 = Card.create(suit: "s", value: 11, round_id: round.id)
  #     card6 = Card.create(suit: "s", value: 9, round_id: round.id)
  #     card7 = Card.create(suit: "s", value: 10, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 7, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "s", value: 6, hand_id: hand.id, round_id: round.id)
  #     expect(hand.rank).to eq(90013)
  #   end
  #
  #   it "gives a rank of 800xx for four_of_a_kind" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 13, round_id: round.id)
  #     card4 = Card.create(suit: "d", value: 13, round_id: round.id)
  #     card5 = Card.create(suit: "c", value: 13, round_id: round.id)
  #     card6 = Card.create(suit: "s", value: 9, round_id: round.id)
  #     card7 = Card.create(suit: "h", value: 13, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 7, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "s", value: 6, hand_id: hand.id, round_id: round.id)
  #     expect(hand.rank).to eq(80013)
  #   end
  #
  #   it "gives a rank of 700xx for full house" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 13, round_id: round.id)
  #     card4 = Card.create(suit: "d", value: 13, round_id: round.id)
  #     card5 = Card.create(suit: "c", value: 9, round_id: round.id)
  #     card6 = Card.create(suit: "s", value: 9, round_id: round.id)
  #     card7 = Card.create(suit: "h", value: 13, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 7, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "s", value: 6, hand_id: hand.id, round_id: round.id)
  #     expect(hand.rank).to eq(70013)
  #   end
  #
  #   it "gives a rank of 600xx for a flush" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 13, round_id: round.id)
  #     card4 = Card.create(suit: "d", value: 12, round_id: round.id)
  #     card5 = Card.create(suit: "s", value: 9, round_id: round.id)
  #     card6 = Card.create(suit: "s", value: 9, round_id: round.id)
  #     card7 = Card.create(suit: "h", value: 13, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 7, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "s", value: 6, hand_id: hand.id, round_id: round.id)
  #     expect(hand.rank).to eq(60013)
  #   end
  #
  #   it "gives a rank of 500xx for a straight" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 13, round_id: round.id)
  #     card4 = Card.create(suit: "d", value: 13, round_id: round.id)
  #     card5 = Card.create(suit: "h", value: 12, round_id: round.id)
  #     card6 = Card.create(suit: "s", value: 10, round_id: round.id)
  #     card7 = Card.create(suit: "h", value: 11, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 9, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "s", value: 6, hand_id: hand.id, round_id: round.id)
  #     expect(hand.rank).to eq(50013)
  #   end
  #
  #   it "gives a rank of 600xx for a flush even if there is a triple in all seven cards" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 13, round_id: round.id)
  #     card4 = Card.create(suit: "d", value: 13, round_id: round.id)
  #     card5 = Card.create(suit: "s", value: 9, round_id: round.id)
  #     card6 = Card.create(suit: "s", value: 9, round_id: round.id)
  #     card7 = Card.create(suit: "h", value: 13, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 7, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "s", value: 6, hand_id: hand.id, round_id: round.id)
  #     expect(hand.rank).to eq(60013)
  #   end
  #
  #   it "gives a rank of 500xx for a straight even if there is a triple in all seven cards" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 13, round_id: round.id)
  #     card4 = Card.create(suit: "d", value: 13, round_id: round.id)
  #     card5 = Card.create(suit: "h", value: 12, round_id: round.id)
  #     card6 = Card.create(suit: "s", value: 10, round_id: round.id)
  #     card7 = Card.create(suit: "h", value: 11, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 9, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "d", value: 13, hand_id: hand.id, round_id: round.id)
  #     expect(hand.rank).to eq(50013)
  #   end
  #
  #   it "gives a rank of 400xx for three_of_a_kind" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 13, round_id: round.id)
  #     card4 = Card.create(suit: "d", value: 13, round_id: round.id)
  #     card5 = Card.create(suit: "h", value: 12, round_id: round.id)
  #     card6 = Card.create(suit: "s", value: 11, round_id: round.id)
  #     card7 = Card.create(suit: "h", value: 13, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 9, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "d", value: 4, hand_id: hand.id, round_id: round.id)
  #     expect(hand.rank).to eq(40013)
  #   end
  #
  #   it "gives a rank of 3xxxx for two pair" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 13, round_id: round.id)
  #     card4 = Card.create(suit: "d", value: 13, round_id: round.id)
  #     card5 = Card.create(suit: "h", value: 12, round_id: round.id)
  #     card6 = Card.create(suit: "s", value: 12, round_id: round.id)
  #     card7 = Card.create(suit: "h", value: 11, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 9, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "d", value: 4, hand_id: hand.id, round_id: round.id)
  #     expect(hand.rank).to eq(31312)
  #   end
  #
  #   it "gives a rank of 2xxxx for a pair" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 13, round_id: round.id)
  #     card4 = Card.create(suit: "d", value: 13, round_id: round.id)
  #     card5 = Card.create(suit: "h", value: 5, round_id: round.id)
  #     card6 = Card.create(suit: "s", value: 6, round_id: round.id)
  #     card7 = Card.create(suit: "h", value: 11, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 9, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "d", value: 4, hand_id: hand.id, round_id: round.id)
  #     expect(hand.rank).to eq(21311)
  #   end
  #
  #   it "gives a rank of 100xx for a high card" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 13, round_id: round.id)
  #     card4 = Card.create(suit: "d", value: 18, round_id: round.id)
  #     card5 = Card.create(suit: "h", value: 5, round_id: round.id)
  #     card6 = Card.create(suit: "s", value: 6, round_id: round.id)
  #     card7 = Card.create(suit: "h", value: 11, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 9, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "d", value: 4, hand_id: hand.id, round_id: round.id)
  #     expect(hand.rank).to eq(10013)
  #   end
  # end
  #
  # describe "add_round_and_sort" do
  #   it "adds cards from the round to the hand and sorts cards by value" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 5, round_id: round.id)
  #     card4 = Card.create(suit: "d", value: 4, round_id: round.id)
  #     card5 = Card.create(suit: "s", value: 3, round_id: round.id)
  #     card6 = Card.create(suit: "d", value: 14, round_id: round.id)
  #     card7 = Card.create(suit: "s", value: 9, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 7, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "c", value: 6, hand_id: hand.id, round_id: round.id)
  #     expect(Hand.add_round_and_sort).to eq([card6, card7, card1, card2, card3, card4, card5])
  #   end
  # end
  #
  # describe "get_five" do
  #   it "returns all combinations of five" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 5, round_id: round.id)
  #     card4 = Card.create(suit: "d", value: 4, round_id: round.id)
  #     card5 = Card.create(suit: "s", value: 3, round_id: round.id)
  #     card6 = Card.create(suit: "d", value: 14, round_id: round.id)
  #     card7 = Card.create(suit: "s", value: 9, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 7, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "c", value: 6, hand_id: hand.id, round_id: round.id)
  #     expect(Hand.combinations).to include([card6, card7, card3, card4, card5])
  #   end
  #   it "has length" do
  #     round = round.create
  #     card3 = Card.create(suit: "s", value: 5, round_id: round.id)
  #     card4 = Card.create(suit: "d", value: 4, round_id: round.id)
  #     card5 = Card.create(suit: "s", value: 3, round_id: round.id)
  #     card6 = Card.create(suit: "d", value: 14, round_id: round.id)
  #     card7 = Card.create(suit: "s", value: 9, round_id: round.id)
  #     hand = hand.create
  #     card1 = Card.create(suit: "s", value: 7, hand_id: hand.id, round_id: round.id)
  #     card2 = Card.create(suit: "c", value: 6, hand_id: hand.id, round_id: round.id)
  #     expect(Hand.combinations.length).to eq(42)
  #   end
  # end
  #
  #
  # describe "straight" do
  #   it "tests if five cards are a straight" do
  #     card1 = Card.create(suit: "s", value: 7)
  #     card2 = Card.create(suit: "c", value: 6)
  #     card3 = Card.create(suit: "s", value: 5)
  #     card4 = Card.create(suit: "d", value: 4)
  #     card5 = Card.create(suit: "s", value: 3)
  #     five = [card1, card2, card3, card4, card5]
  #     expect(Hand.straight(five)).to eq(7)
  #   end
  #   it "tests returns 0 if hand is not a straight" do
  #     card1 = Card.create(suit: "s", value: 7)
  #     card2 = Card.create(suit: "c", value: 12)
  #     card3 = Card.create(suit: "s", value: 5)
  #     card4 = Card.create(suit: "d", value: 4)
  #     card5 = Card.create(suit: "s", value: 3)
  #     five = [card1, card2, card3, card4, card5]
  #     expect(Hand.straight(five)).to eq(0)
  #   end
  # end
  #
  # describe "flush" do
  #   it "tests if five cards are a flush" do
  #     card1 = Card.create(suit: "s", value: 7)
  #     card2 = Card.create(suit: "s", value: 8)
  #     card3 = Card.create(suit: "s", value: 5)
  #     card4 = Card.create(suit: "s", value: 4)
  #     card5 = Card.create(suit: "s", value: 3)
  #     five = [card1, card2, card3, card4, card5]
  #     expect(Hand.flush(five)).to eq(7)
  #   end
  #   it "tests returns 0 if hand is not a flush" do
  #     card1 = Card.create(suit: "s", value: 7)
  #     card2 = Card.create(suit: "c", value: 12)
  #     card3 = Card.create(suit: "s", value: 5)
  #     card4 = Card.create(suit: "d", value: 4)
  #     card5 = Card.create(suit: "s", value: 3)
  #     five = [card1, card2, card3, card4, card5]
  #     expect(Hand.flush(five)).to eq(0)
  #   end
  # end

end

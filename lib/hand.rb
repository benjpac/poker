class Hand < ActiveRecord::Base
  has_many :cards
  belongs_to :player
  belongs_to :deck
  belongs_to :round

  def add_flop_and_sort
    seven_cards = self.cards + flop.cards
    small_to_large = seven_cards.sort_by {|card| card.value}
    return sorted = small_to_large.reverse
  end

  def get_five
    combinations = []
    seven = self.add_flop_and_sort
    seven.each do |card1|
      six = seven - [card1]
      six.each do |card2|
        five = six - [card2]
        combinations.push(five)
      end
    end
    return combinations
  end

  def rank_hand
    combinations = self.get_five()
    flush = 0
    flush_hand = []
    straight = 0
    straight_hand = []
    four_of_a_kind = 0
    four_of_a_kind_hand = []
    three_of_a_kind = 0
    three_of_a_kind_hand = []
    pair = 0
    pair_hand = []

    score = 0
    combinations.each do |five|
      if Hand.flush(five) > flush
        flush = Hand.flush(five)
      end
    end

    combinations.each do |five|
      if Hand.straight(five) > straight
        straight = Hand.straight(five)
      end
    end

    combinations.each do |five|
      if Hand.four_of_a_kind(five) > four_of_a_kind
        four_of_a_kind = Hand.four_of_a_kind(five)
      end
    end

    combinations.each do |five|
      if Hand.three_of_a_kind(five) > three_of_a_kind
        three_of_a_kind = Hand.three_of_a_kind(five)
      end
    end

    combinations.each do |five|
      if Hand.pair(five) > pair
        pair = Hand.pair(five)
      end
    end

    if flush > 0 && straight >> 0
      score = 900 + flush
    elsif four_of_a_kind > 0
      score = 800 + four_of_a_kind
    elsif three_of_a_kind > 0
      #test for full house
    end
  end

  class << self

    def straight(five)
      (0..3).each do |i|
        if five[i].value - 1 == five[i + 1].value
        else
          return 0
        end
      end
      return five[0].value
    end

    def flush(five)
      (0..3).each do |i|
        if five[i].suit  == five[i + 1].suit
        else
          return 0
        end
      end
      return five[0].value
    end

    def four_of_a_kind(five)
      five.each do |card|
        four = five - [card]
        if four[0].value == four[1].value && four[1].value == four[2].value && four[2].value == four[3].value
          return four[0].value
        end
      end
      return 0
    end

    def three_of_a_kind(five)
      five.each do |card|
        four = five - [card]
        four.each do |card1|
          three = four - [card]
          if three[0].value == three[1].value && three[1].value == three[2].value
            return three[0].value
          end
        end
      end
      return 0
    end

    def pair(five)
      five.each do |card1|
        five.each do |card2|
          if card1.value == card2.value
            return card1.value
          end
        end
      end
      return 0
    end

  end
end

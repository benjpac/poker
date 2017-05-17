class Hand < ActiveRecord::Base
  has_many :cards
  belongs_to :round
  belongs_to :player

  # def fold
  #   self.round.update(pot: self.rount.pot + self.bet)
  #   self.update (bet: 0)
  #   destroy
  # end
  #
  # def bet(amt)
  #   self.player.update(money: self.player.money - amt)
  #   self.update(bet: self.bet + amt)
  # end

  def create_hand
    for i in 1..2
      random_card = Card.pull_random_card
      random_card.update(hand_id: self.id)
    end
  end

  def add_round_and_sort(round)
    seven_cards = self.cards + round.cards
    small_to_large = seven_cards.sort_by {|card| card.value}
    return sorted = small_to_large.reverse
  end

  def combinations(round)
    combinations = []
    seven = self.add_round_and_sort(round)
    seven.each do |card1|
      six = seven - [card1]
      six.each do |card2|
        five = six - [card2]
        combinations.push(five)
      end
    end

    return combinations
  end

  def rank_hand(round)
    combinations = self.combinations(round)
    seven = self.add_round_and_sort(round)

    flush = 0
    flush_hand = []
    straight = 0
    straight_hand = []
    four_of_a_kind = 0
    four_of_a_kind_hand = []
    full_house = 0
    full_house_hand = []
    three_of_a_kind = 0
    three_of_a_kind_hand = []
    pair = 0
    pair_hand = []

    score = 0

    # hand_types = ["flush", "straight", "four_of_a_kind", "three_of_a_kind", "pair"]
    # hand_types.each do |hand_type|
    #   hand_type = find_highest_of_hand_type (hand_type, combinations)
    # end


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

    if flush > 0 && straight > 0
      score = 90000 + flush
    elsif four_of_a_kind > 0
      score = 80000 + four_of_a_kind
    elsif three_of_a_kind > 0
      four = seven.delete_if {|card| card.value == three_of_a_kind}
      if Hand.pair(four) > 0
        score = 70000 + three_of_a_kind
      else
        if flush > 0
          score = 60000 + flush
        elsif straight > 0
          score = 50000 + straight
        else
          score = 40000 + three_of_a_kind
        end
      end
    elsif flush > 0
      score = 60000 + flush
    elsif straight > 0
      score = 50000 + straight
    elsif pair > 0
      five = seven.delete_if {|card| card.value == pair}
      if Hand.pair(five) > 0
        score = 30000 + 100*pair + Hand.pair(five)
      else
        score = 20000 + 100*pair + five[0].value
      end
    else
      score = 10000 + seven[0].value
    end
  end


  # def find_highest_of_hand_type(hand_type, combinations)
  #   score = 0
  #   combinations.each do |five|
  #     if Hand.send (:hand_type, five) > score
  #       score = Hand.send (:hand_type, five)
  #     end
  #   end
  #   return score
  # end

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
      five.each do |card|
        four = five - [card]
        four.each do |card1|
          if card.value == card1.value
            return card1.value
          end
        end
      end
      return 0
    end
  end
end

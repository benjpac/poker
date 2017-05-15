class Flop < ActiveRecord::Base
  has_many :cards

  def self.deal_flop
    flop = []
    for i in 1..3
      flop.push(Card.deal_card)
    end
    return flop
  end

end

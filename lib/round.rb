class Round < ActiveRecord::Base
  has_many :cards
  belongs_to :deck
  # after_create(:create_flop)
  #
  # def create_flop
  #   deck = self.deck
  #   for i in 1..3
  #     random_card = deck.pull_random_card
  #     random_card.update(round_id: self.id)
  #   end
  # end

end

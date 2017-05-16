class Card < ActiveRecord::Base
  belongs_to :hand
  belongs_to :round
  belongs_to :deck

  def image_string
    suit = self.suit
    value = self.value.to_s
    return suit + "_" + value
  end

end

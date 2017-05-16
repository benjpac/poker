class Card < ActiveRecord::Base
  belongs_to :hand
  belongs_to :round
  belongs_to :deck
end

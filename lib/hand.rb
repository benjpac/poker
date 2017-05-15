class Hand < ActiveRecord::Base
  belongs_to :player
  has_many :cards

  def self.deal_to_player
    
  end
end

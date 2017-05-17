require 'bundler/setup'
Bundler.require :default
also_reload 'lib/**/*.rb'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get '/' do
  erb :index
end

get '/how_many_players'do
  erb :how_many_players
end

get '/deal' do
  erb :deal
end

get '/2_player_deal' do
  Card.create_deck
  @hand = Hand.create
  @hand.create_hand
  @round = Round.create
  @card_urls = []
  @round.cards.each do |card|
    @card_urls.push(card.image_string)
  end
  erb :two_player_deal
end




get '/text' do
  erb :text
end

get '/text/form' do
  erb :text_form
end

post '/text/form' do
  redirect '/text/form'
end

post '/text/players' do
  round = Round.create(pot: 0)
  player1 = Player.create(name: params[:player1], money: 99, round_id: round.id)
  player2 = Player.create(name: params[:player2], money: 98, round_id: round.id)
  Card.create_deck
  hand1 = Hand.create(bet: 1, player_id: player1.id)
  hand1.create_hand
  hand2 = Hand.create(bet: 2, player_id: player2.id)
  hand2.create_hand
  round.update(pot: 0, active_player_id: player1.id)
  redirect '/text/2_player/round/'.concat(round.id.to_s)
end

get '/text/2_player/round/:round_id' do
  Card.create_deck
  # @players = Player.all
  # @hands = Hand.all
  @round = Round.find(params[:round_id].to_i)
  erb :text_game
end

post '/text/fold/round/:round_id/' do
  round = Round.find(params[:round_id])
  active_player = Player.find(round.active_player_id.to_i)
  active_player.hands.first




end

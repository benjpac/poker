require 'bundler/setup'
Bundler.require :default
also_reload 'lib/**/*.rb'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get '/' do
  erb :index
end

get '/text' do
  erb :text
end

get '/deal' do
  erb :deal
end

get '/player_names' do
  erb :player_names
end

post '/play_game' do
  round = Round.create(pot: 0)
  player1 = Player.create(name: params[:player1], money: 100)
  player2 = Player.create(name: params[:player2], money: 100)
  round.create_game(player1, player2, 1)
  redirect '/text/2_player/round/'.concat(round.id.to_s)
end

get '/text/2_player/round/:round_id' do
  Card.create_deck
  # @players = Player.all
  # @hands = Hand.all
  @round = Round.find(params[:round_id].to_i)
  binding.pry
  erb :text_game
end

patch '/text/fold/round/:round_id' do
  round = Round.find(params[:round_id])
  active_player = Player.find(round.active_player_id.to_i)
  inactive_player = Player.find(round.inactive_player_id.to_i)
  inactive_player.hand.win
  new_round = Round.create(pot: 0)
  binding.pry
  new_round.create_game(inactive_player, active_player, 1)
  binding.pry
  redirect '/text/2_player/round/'.concat(new_round.id.to_s)




end

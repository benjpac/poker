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
  player1 = Player.create(name: params[:player1], money: 100)

  player2 = Player.create(name: params[:player2], money: 100)
  Card.create_deck
  hand1 = player1.hands.create(bet: 0)
  hand1.create_hand
  hand2 = player2.hands.create(bet: 0)
  hand2.create_hand
  round = Round.create(active_player_id: player1.id)
  redirect '/text/2_player/round/'.concat(round.id.to_s)
end

get '/text/2_player/round/:round_id' do
  Card.create_deck
  @players = Player.all
  @hands = Hand.all
  @round = Round.find(params[:round_id].to_i)
  erb :text_game
end

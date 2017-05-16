require 'bundler/setup'
Bundler.require :default
also_reload 'lib/**/*.rb'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get '/' do
  erb(:index)
end

get '/how_many_players'do

  erb(:how_many_players)
end

get '/deal' do
  erb(:deal)
end

get '/2_player_deal' do
  
  erb(:two_player_deal)
end

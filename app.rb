require 'sinatra'
require './aiop'

set :server, 'thin'
set :haml, :format => :html5

get '/' do
  haml :index
end

get '/fetch' do
  c = TwitterClient.new
  distance = params[:distance] || '.25' 
  c.search(distance)
  c.get_json
end

require 'sinatra'
require 'data_mapper'
require 'json'

set :port, 12008

get '/' do
  erb :home
end

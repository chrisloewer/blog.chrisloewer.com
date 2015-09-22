require 'sinatra'
require 'data_mapper'
require 'json'

set :port, 12008

# DATABASE
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/posts.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, Text, :required => true, :lazy =>false
  property :author, Text, :lazy =>false
  property :content, Text, :required => true
  property :preview, Text, :required => true
  property :time, DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do
  erb :home
end

get '/api/posts' do
  @posts = Post.all
  @posts.to_json()
end

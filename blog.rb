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
  property :path, Text
end

DataMapper.finalize.auto_upgrade!

# ROUTING
get '/' do
  @tab_title = 'Techster'
  erb :home
end

get '/:path' do |p|
  @tab_title= p.split('-').map(&:capitalize).join(' ')

  @path = p
  erb :post
end

# APIs
get '/api/posts' do
  @posts = Post.all
  @posts.to_json()
end

get '/api/posts/:path' do |p|
  @post = Post.first(:path => p)
  @post.to_json();
end

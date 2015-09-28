require 'sinatra'
require 'json'
require 'active_record'

set :port, 12008

# DATABASE
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'posts.db'
)

class Post < ActiveRecord::Base
end


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
  @post = Post.find_by path: p
  @post.to_json();
end


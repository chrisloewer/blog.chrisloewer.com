require 'sinatra'
require 'json'
require 'active_record'

set :port, 12568
set :environment, :production

# DATABASE
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'posts.db'
)

class Post < ActiveRecord::Base
end


# ROUTING

# NOTE - blog located under '/blog/' subdirectory
#        All paths must start with /blog/

get '/blog/' do
  @tab_title = 'Techster'
  erb :home
end

get '/blog/:path' do |p|
  @tab_title= p.split('-').map(&:capitalize).join(' ')

  @path = p
  erb :post
end

# APIs
get '/blog/api/posts' do
  @posts = Post.all
  @posts.to_json()
end

<<<<<<< HEAD
get '/blog/api/posts/:path' do |p|
  @post = Post.first(:path => p)
  @post.to_json();
end


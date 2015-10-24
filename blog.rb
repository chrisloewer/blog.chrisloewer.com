require 'sinatra'
require 'json'
require 'data_mapper'
require 'tilt/erb'

set :port, 12568
set :environment, :production


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

get '/blog/api/posts/:path' do |p|
  @post = Post.first(:path => p)
  @post.to_json();
end


# SERVE STATIC FILES (js, images, etc)

# Configure mime types
configure do
  mime_type :js, 'application/javascript'
end
configure do
  mime_type :svg, 'image/svg+xml'
end

# Actually read in static file
def js(f)
  File.read(File.join('public/js', "#{f.to_s}"))
end
def svg(f)
  puts 'svg'
  File.read(File.join('public/img', "#{f.to_s}"))
end

# paths to catch static files
get '/blog/js/*' do |file|
  content_type :js
  js file
end

get '/blog/img/*.*' do |file, ext|
  if ext == 'svg'
    puts 'SVG'
    content_type :svg
    svg(file + '.' + ext)
  end
end

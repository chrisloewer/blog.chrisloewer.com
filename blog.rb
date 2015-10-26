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
  @posts = Post.all(:order => [:id.desc])
  @posts.to_json()
end

get '/api/posts/:path' do |p|
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
  File.read(File.join('public/img', "#{f.to_s}"))
end

# paths to catch static files
get '/js/*' do |file|
  content_type :js
  js file
end

get '/img/*.*' do |file, ext|
  if ext == 'svg'
    content_type :svg
    svg(file + '.' + ext)
  end
end

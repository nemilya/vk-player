require 'rubygems'
require 'haml'
require 'sinatra'

VK = true

before do
  headers 'X-Frame-Options'=> 'GOFORIT'
  @ts = ''
  configure :development do
    t = Time.now.strftime('%Y%m%d%H%M%S')
    @ts = "?#{t}"
  end
end

get '/' do
  haml :index
end
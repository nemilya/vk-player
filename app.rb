require 'rubygems'
require 'haml'
require 'sinatra'

# remote access to VK.api - work within IFrame
VK = true

# or local for direct URL test
# VK = false


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
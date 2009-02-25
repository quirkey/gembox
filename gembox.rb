require 'rubygems'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'lib', 'gembox')

Gembox::Gems.load

helpers do
  def link_to(text, link = nil)
    link ||= text
    "<a href=\"#{link}\">#{text}</a>"
  end
  
  def escape(text)
    CGI.escapeHTML(text)
  end
end

set :public, 'public'
set :views,  'views'

get '/' do
  @gems = Gembox::Gems.local_gems
  haml :index
end

get '/gems/?' do
  
end

get '/gems/:name' do
  
end

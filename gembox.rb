require 'rubygems'
require 'sinatra'

require File.join(File.dirname(__FILE__), 'lib', 'gembox')

Gembox::Gems.load

helpers do
  def link_to(text, link = nil)         
    link ||= text
    link = url_for(link)
    "<a href=\"#{link}\">#{text}</a>"
  end
  
  def url_for(link_options)
    case link_options
    when Hash
      path = link_options.delete(:path) || request.path_info
      path + '?' + build_query(params.merge(link_options))
    else
      link_options
    end
  end
end

set :public, 'public'
set :views,  'views'

before do
  @gems = Gembox::Gems.local_gems
  @stats = Gembox::Gems.stats
end

get '/stylesheets/:stylesheet.css' do
  sass params[:stylesheet].to_sym
end

get '/' do
  haml :index
end

get %r{/gems/([\w\-\_]+)/?([\d\.]+)?/?} do
  show_layout = params[:layout] != 'false'
  name, version = params[:captures]
  @gems = Gembox::Gems.search(name, version)
  raise Sinatra::NotFound if @gems.empty?
  @gem_versions = @gems.shift[1]
  @gem = @gem_versions.shift
  haml :gem, :layout => show_layout
end

get '/gems/?' do
  show_layout = params[:layout] != 'false'
  show_as = params[:as] || 'columns'
  haml "gems_#{show_as}".to_sym, :layout => show_layout
end


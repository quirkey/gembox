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
  
  def link_to_gem(gem, options = {})
    text    = options[:text] || gem.name
    version = gem.version if options[:show_version]
    link_to(text, "/gems/#{gem.name}/#{gem.version}")
  end
  
  def url_for(link_options)
    case link_options
    when Hash
      path = link_options.delete(:path) || request.path_info
      params.delete('captures')
      path + '?' + build_query(params.merge(link_options))
    else
      link_options
    end
  end
    
  def ts(time)
    time.strftime('%b %d, %Y') if time
  end
  
  def clippy(text, bgcolor='#FFFFFF')
    html = <<-EOF
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="110"
              height="14"
              id="clippy" >
      <param name="movie" value="/swf/clippy.swf"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="text=#{text}">
      <param name="bgcolor" value="#{bgcolor}">
      <embed src="/swf/clippy.swf"
             width="110"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="text=#{text}"
             bgcolor="#{bgcolor}"
      />
      </object>
    EOF
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
  redirect '/gems'
end

get %r{/gems/([\w\-\_]+)/?([\d\.]+)?/?} do
  show_layout = params[:layout] != 'false'
  name, version = params[:captures]
  @gems = Gembox::Gems.search(name)
  raise Sinatra::NotFound if @gems.empty?
  @gem_versions = @gems[0][1]
  if version
    @gems = Gembox::Gems.search(name, version)
    @gem  = @gems.shift[1].first if @gems
  end
  if !@gem
    @gem = @gem_versions.shift
    redirect "/gems/#{@gem.name}/#{@gem.version}"
  end
  if params[:file]
    action = params[:action] || view
    file_path = File.join(@gem.full_gem_path, params[:file])
    if action == 'edit'
      `$EDITOR #{file_path}`
    else
      headers['Content-type'] = 'text/plain'
      File.read(file_path)
      return
    end
  end
  haml :gem, :layout => show_layout
end

get '/gems/?' do
  show_layout = params[:layout] != 'false'
  show_as = params[:as] || 'columns'
  haml "gems_#{show_as}".to_sym, :layout => show_layout
end
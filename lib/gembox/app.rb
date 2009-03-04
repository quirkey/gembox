require 'sinatra'

module Gembox
  class App < ::Sinatra::Default
    include Gembox::ViewHelpers  
    include WillPaginate::ViewHelpers
      
    @@root = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
    
    set :public, File.join(@@root,'public')
    set :views,  File.join(@@root,'views')

    before do
      Gembox::Gems.load
      @gems = Gembox::Gems.local_gems.paginate :page => params[:page], :per_page => 30
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
        if File.readable?(file_path)
          if action == 'edit'
            `$EDITOR #{file_path}`
          else
            response.headers['Content-type'] = 'text/plain'
            return File.read(file_path)
          end
        end
      end
      haml :gem, :layout => show_layout
    end

    get '/gems/?' do
      show_layout = params[:layout] != 'false'
      @show_as = params[:as] || 'columns'
      if @search = params[:search]
        @gems = Gembox::Gems.search(@search).paginate :page => params[:page] 
      end
      haml "gems_#{@show_as}".to_sym, :layout => show_layout
    end
    
  end
end
require 'sinatra'

module Gembox
  class App < ::Sinatra::Base
    include Gembox::ViewHelpers  
    include WillPaginate::ViewHelpers
      
    @@root = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))

    set :root,  @@root    
    set :app_file, __FILE__
        
    before do
      Gembox::Gems.load
      @gems  = Gembox::Gems.local_gems.paginate :page => params[:page], :per_page => 30
      @stats = Gembox::Gems.stats
      @search ||= ''
      @environment = options.environment
    end

    get '/stylesheets/:stylesheet.css' do
      sass params[:stylesheet].to_sym
    end

    get '/' do
      redirect '/gems'
    end
    
    get %r{/gems/doc/([\w\-\_]+)/?([\d\.]+)?/?(.*)?} do
      load_gem_by_version
      @rdoc_path = @gem.rdoc_path
      if params[:captures].length == 3 && !params[:captures][2].blank? 
        # we have a path
        full_path = File.join(@rdoc_path, params[:captures].pop)
        content_type File.extname(full_path)
        File.read(full_path)
      else
        haml :doc, :layout => false
      end
    end
    
    get %r{/gems/([\w\-\_]+)/?([\d\.]+)?/?} do
      show_layout = params[:layout] != 'false'
      load_gem_by_version
      if params[:file]
        action = params[:action] || 'view'
        file_path = File.join(@gem.full_gem_path, params[:file])
        if File.readable?(file_path)
          if action == 'edit' && !production?
            `$EDITOR #{file_path}`
          else
            content_type 'text/plain'
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
        if !@gems.empty? && gem = @gems.find {|k,v| k.strip == @search.strip }
          gem = gem[1][0]
          redirect "/gems/#{gem.name}/#{gem.version}" and return
        end
      end
      haml "gems_#{@show_as}".to_sym, :layout => show_layout
    end
   
    def self.version
      Gembox::VERSION
    end
   
    private
    
    def load_gem_by_version
      name, version = params[:captures]
      @gems = Gembox::Gems.search(name, nil, true)
      raise @gems.inspect if @gems.empty?
      @gem_versions = @gems[0][1]
      if version
        @gems = Gembox::Gems.search(name, version)
        @gem  = @gems.shift[1].first if @gems
      end
      if !@gem
        @gem = @gem_versions.shift
        redirect "/gems/#{@gem.name}/#{@gem.version}"
      end
    end
    
    
  end
end
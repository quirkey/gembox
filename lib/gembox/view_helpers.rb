module Gembox
  module ViewHelpers
    
    def tag_options(options, escape = true)
      option_string = options.collect {|k,v| %{#{k}="#{v}"}}.join(' ')
      option_string = " " + option_string unless option_string.blank?
    end

    def content_tag(name, content, options, escape = true)
      tag_options = tag_options(options, escape) if options
      "<#{name}#{tag_options}>#{content}</#{name}>"
    end

    def link_to(text, link = nil, options = {})         
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

    def rdocify(text)
      @_rdoc ||= RDoc::Markup::ToHtml.new
      @_rdoc.convert(text)
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
end
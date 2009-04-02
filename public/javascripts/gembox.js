(function($) {
  $.metadata.setType("attr", "data");
  
  function clippy(path, bgcolor) {
    return '<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"' +
            'width="110"' +
            'height="14"' +
            'id="clippy" >' +
    '<param name="movie" value="/swf/clippy.swf"/>'     +
    '<param name="allowScriptAccess" value="always" />' +
    '<param name="quality" value="high" />'             +
    '<param name="scale" value="noscale" />'            +
    '<param NAME="FlashVars" value="text=#{text}">'     +
    '<param name="bgcolor" value="' + bgcolor +'">'        +
    '<embed src="/swf/clippy.swf"'                      +
    '       width="110"'                                               +
    '       height="14"'                                               +
    '       name="clippy"'                                             +
    '       quality="high"'                                            +
    '       allowScriptAccess="always"'                                +
    '       type="application/x-shockwave-flash"'                      +
    '       pluginspage="http://www.macromedia.com/go/getflashplayer"' +
    '       FlashVars="text='+ path + '"'                              +
    '       bgcolor="'+ bgcolor +'"'                                   +
    '/>'                                                               +
    '</object>';
  }
  
  Gembox = {
    initialize: function() {
      this.setFileHover();
    },
    setFileHover: function() {
      $('li.dir').hover(
        function() {
          $(this).addClass('file_hover')
                 .children('ul').show();
          var $file = $(this).children('.file')
          var meta = $file.metadata();
          if ($file.next('.controls').length > 0) {
            $file.next('.controls').show();
          } else {
            // build controls
            var $controls = $('<span class="controls"></span>');
            $('<a><img src="/images/edit.png" alt="Edit"/></a>')
            .attr('href', meta.url + '&action=edit')
            .appendTo($controls);
            if (!meta.subdirs) {
              $('<a><img src="/images/page_white_text.png" alt="View Raw"/></a>')
              .attr('href', meta.url + '&action=view')
              .appendTo($controls);
            }
            if (meta.github) {
              $('<a><img src="/images/git.gif" alt="On Github"/></a>')
              .attr('href', meta.github)
              .appendTo($controls);
            }
            $(clippy(meta.filename, '#F4F6E6')).appendTo($controls);
            $file.after($controls);
          }        
        }, 
        function() {
          $(this)
          .children('ul').hide().end()
          .removeClass('file_hover')
          .children('.controls').hide();
        }
      );
    }
  };

  $(function() {
    Gembox.initialize();
  });
})(jQuery);
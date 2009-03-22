(function(){
  var initializing = false, fnTest = /xyz/.test(function(){xyz;}) ? /\b_super\b/ : /.*/;

  // The base Class implementation (does nothing)
  this.Class = function(){};
 
  // Create a new Class that inherits from this class
  Class.extend = function(prop) {
    var _super = this.prototype;
   
    // Instantiate a base class (but only create the instance,
    // don't run the init constructor)
    initializing = true;
    var prototype = new this();
    initializing = false;
   
    // Copy the properties over onto the new prototype
    for (var name in prop) {
      // Check if we're overwriting an existing function
      prototype[name] = typeof prop[name] == "function" &&
        typeof _super[name] == "function" && fnTest.test(prop[name]) ?
        (function(name, fn){
          return function() {
            var tmp = this._super;
           
            // Add a new ._super() method that is the same method
            // but on the super-class
            this._super = _super[name];
           
            // The method only need to be bound temporarily, so we
            // remove it when we're done executing
            var ret = fn.apply(this, arguments);       
            this._super = tmp;
           
            return ret;
          };
        })(name, prop[name]) :
        prop[name];
    }
   
    // The dummy class constructor
    function Class() {
      // All construction is actually done in the init method
      if ( !initializing && this.init )
        this.init.apply(this, arguments);
    }
   
    // Populate our constructed prototype object
    Class.prototype = prototype;
   
    // Enforce the constructor to be what we expect
    Class.constructor = Class;

    // And make this class extendable
    Class.extend = arguments.callee;
   
    return Class;
  };
})();


$.fn.extend({
	getId: function() {
		var match = $(this).attr("id").match(/\d+/)
		return match ? parseInt(match[0]) : null;
	},
	setInputHint: function() {
		el = $(this);
		el.data('default', el.val());

		el.focus(function() {
			if(el.data('default') != el.val()) return;
			el.removeClass('hint').val('');
		})
		.blur(function() {
			if($.trim(el.val()) != '') return;
			el.addClass('hint').val(el.data('default'));
		})
		.addClass('hint');
	},
	fadeUp: function(speed) {
		$(this).css({'position':'relative'}).animate({top:"-150px", opacity: 0}, speed, function() { $(this).remove(); })
		return $(this);
	}
});

$.extend({
	log: function()	{
		if (typeof console == 'undefined') {
			// do nothing
		} else {
			console.log(arguments);
		}
	},
	timestamp: function() {
		return Math.floor(new Date().getTime()/1000);
	}
});

// authenticity tokens
// http://www.viget.com/extend/ie-jquery-rails-and-http-oh-my
$(function() {
	$(document).ajaxSend(function(event, request, settings) {
	  if (settings.type == 'GET' || settings.type == 'get' || typeof(AUTH_TOKEN) == "undefined") return;
	  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
	  settings.data = settings.data || "";
	  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
	});
});

var Base = {
	popup: function (link,title,width,height) {
		return window.open(link,title,"height="+height+",width="+width+",status=no,toolbar=no,menubar=no,location=no");
	},
	urlify: function(title) {
		// self.downcase.gsub(/(_|-|\/|\\|\&|,| )/,'_')[0..40]
		return title.toString().strip().toLowerCase().gsub(/ /, '_').gsub(/[^a-z0-9\-_]/,'').truncate(40,'');
	},
	copyTextToClipboard: function(text) {
		// create form element
		var form_element = $('clipboard_holder') ? $('clipboard_holder') : new Element('input',{'type':'hidden','id':'clipboard_holder','name':'clipboard_holder','value':text});
	  if (form_element.createTextRange) {
	    var range = form_element.createTextRange();
	    if (range && BodyLoaded==1)
	     range.execCommand('Copy');
	  } else {
	    var flashcopier = $('flashcopier') ? $('flashcopier') : new Element('div',{id: 'flashcopier'});
			$(flashcopier).innerHTML = '<embed src="/swf/_clipboard.swf" FlashVars="clipboard='+escape(form_element.value)+'" width="0" height="0" type="application/x-shockwave-flash"></embed>';
			document.body.appendChild(flashcopier);
	 }
	},
	images: {
		hover_suffix: '_on',
		active_suffix: '_on',
		deactive_suffix: '_off',
		swap: function(for_el,to) {
			$(for_el).attr('src', to);
		},
		activate: function (for_el) {
			return this.swap(for_el,this.activateSrc(for_el));
		},
		deactivate: function (for_el) {
			return this.swap(for_el,this.deactivateSrc(for_el));		
		},
		hover: function (for_el) {
			return this.swap(for_el,this.hoverSrc(for_el));
		},
		replaceSrc: function (for_el,search,replace_with) {
			return $(for_el).attr('src').replace(search,replace_with);
		},
		activateSrc: function (for_el) {
			return this.replaceSrc(for_el,this.deactive_suffix,this.active_suffix);
		},
		deactivateSrc: function (for_el) {
			return this.replaceSrc(for_el,this.active_suffix,this.deactive_suffix);
		},
		hoverSrc: function (for_el) {
			return this.replaceSrc(for_el,this.deactive_suffix,this.hover_suffix);
		},
		restore: function (for_el) {
			MM_swapImgRestore();
		}
	}
};

$.extend({
	param: function( a, nest_in ) {
		var s = [ ];
		// check for nest
		if (typeof nest_in == 'undefined') nest_in = false;
		
		function nested(key) {
			if (nest_in)
				return nest_in + '[' + key + ']';
			else
				return key;
		}
		function add( key, value ){
			key = nested(key)
			s[ s.length ] = encodeURIComponent(key) + '=' + encodeURIComponent(value);
		};
		// If an array was passed in, assume that it is an array
		// of form elements
		if ( jQuery.isArray(a) || a.jquery )
			// Serialize the form elements
			jQuery.each( a, function(){
				add( this.name, this.value );
			});

		// Otherwise, assume that it's an object of key/value pairs
		else
			// Serialize the key/values
			for ( var j in a )
				// If the value is an array then the key names need to be repeated
				if ( jQuery.isArray(a[j]) )
					jQuery.each( a[j], function(){
						add( j, this );
					});
				else if (a[j].constructor == Object)
					s.push($.param(a[j], nested(j)));
				else
					add( j, jQuery.isFunction(a[j]) ? a[j]() : a[j] );

		// Return the resulting serialization
		return s.join("&").replace(/%20/g, "+");
	},
	shove: function(fn, object) {
    return function() {
      return fn.apply(object, arguments);
    }
	}
});

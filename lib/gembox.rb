$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'haml'
require 'sass'
require 'active_support'
require 'rdoc/markup/to_html'
require 'will_paginate/array'
require 'will_paginate/view_helpers'

module Gembox
  VERSION = '0.1.5'
end

require 'gembox/extensions'
require 'gembox/gem_list'
require 'gembox/gems'
require 'gembox/view_helpers'
require 'gembox/app'
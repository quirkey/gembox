$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'haml'
require 'sass'
require 'active_support/core_ext/array/grouping'
require 'active_support/core_ext/hash'
require 'rdoc/markup/to_html'
require 'will_paginate'
require 'will_paginate/view_helpers'

module Gembox
  VERSION = '0.2.3'
end

require 'gembox/extensions'
require 'gembox/gem_list'
require 'gembox/gems'
require 'gembox/view_helpers'
require 'gembox/app'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Gembox
  VERSION = '0.0.1'
end

require 'rubygems'
require 'active_support'
require 'will_paginate/array'
require 'will_paginate/view_helpers'

require 'extensions'
require 'gembox/gem_list'
require 'gembox/gems'
require 'gembox/view_helpers'
require 'gembox/app'
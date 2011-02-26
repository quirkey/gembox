%w[rubygems rake rake/clean rake/testtask fileutils].each { |f| require f }
require File.dirname(__FILE__) + '/lib/gembox'

begin
  require 'jeweler'
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

Jeweler::Tasks.new do |s|
  s.name = %q{gembox}
  s.version = Gembox::VERSION 
  s.authors = ["Aaron Quint"]
  s.summary              = "A sinatra based interface for browsing and admiring your gems."
  s.description          = "A sinatra based interface for browsing and admiring your gems."
  s.email = ["aaron@quirkey.com"]
  s.homepage = %q{http://code.quirkey.com/gembox}
  s.rubyforge_project = %q{quirkey}

  [
   ['sinatra', '~>1.0'],
   ['vegas', '~>0.1.0'],
   ['haml', '~>2.0.9'],
   ['rdoc', '=2.4.3'],
   ['activesupport', '~>3.0.0'],
   ['will_paginate', '~>2.3.7']
  ].each do |n, v|
    s.add_runtime_dependency(n, v)
  end
  [
   ['bacon', '~>1.1.0'],
   ['mocha', '~>0.9.12'],
   ['nokogiri', '~>1.4.4'],
   ['rack-test', '~>0.5.7']
  ].each { |n, v| s.add_development_dependency(n,v) }
end

Jeweler::GemcutterTasks.new

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end


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
   ['activesupport', '~>2.2.2'],
   ['will_paginate', '~>2.3.7']
  ].each do |n, v|
    s.add_runtime_dependency(n, v)
  end
end

Jeweler::GemcutterTasks.new

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end


# To use with thin 
#  thin start -p PORT -R config.ru

require File.join(File.dirname(__FILE__), 'gembox')

disable :run
set :env, :production
run Gembox::App
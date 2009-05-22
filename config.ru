# To use with thin 
#  thin start -p PORT -R config.ru
require File.join(File.dirname(__FILE__), 'lib', 'gembox')

disable :run
Gembox::App.set({
  :environment => :production
})
run Gembox::App
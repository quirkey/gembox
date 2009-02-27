require File.join(File.dirname(__FILE__), "test_helper.rb")
require 'gembox/cli'

class TestGemboxCli < Test::Unit::TestCase
  def setup
    Gembox::CLI.execute(@stdout_io = StringIO.new, [])
    @stdout_io.rewind
    @stdout = @stdout_io.read
  end
  
  def test_not_print_default_output
    assert_no_match(/To update this executable/, @stdout)
  end
end
require 'test_helper'

describe "Gembox App" do
  
  describe 'getting /' do
    before do
      get '/'
    end
    
    should 'load the index' do  
      should.be.ok
    end
    
    should "display gem list" do
      body.should have_element('#gems')
    end
    
    should "display list of installed gems" do
      body.should have_element('.gem', /sinatra/)
    end
  end
  
  describe 'getting gems/ with layout = false' do
    before do
      get '/gems/?layout=false'
    end
    
    should "load" do
      should.be.ok
    end
    
    should "not display layout" do
      body.should.not have_element('html')
    end
    
    should "display gem list" do
      body.should have_element('#gems')
    end
  end
  
  describe 'getting gems/:name' do
    before do
      get '/gems/sinatra'
    end
    
    should "display only specific gem" do
      body.should.not have_element('.gem', /rack/)
    end

    should "display link to gems website" do
      body.should have_element('a', 'http://sinatra.rubyforge.org')
    end
    
  end
  
end
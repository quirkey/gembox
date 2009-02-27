require File.join(File.dirname(__FILE__), 'test_helper')

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

    should "display as 4 columns" do
      body.should have_element('.column')
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

    should "display as 4 columns" do
      body.should have_element('.column')
    end
  end

  describe 'getting gems/ with a simple search' do
    before do
      get '/gems/?search=s'
    end

    should "load" do
      should.be.ok
    end

    should "display gem list" do
      body.should have_element('#gems')
    end

    should "display gems that match the search" do
      body.should have_element('.gem', /sinatra/)
    end

    should "not display gems that do not match the search" do
      body.should.not have_element('.gem', /rack/)
    end
  end

  describe 'getting gems/ with as = table' do
    before do
      get '/gems/?layout=false&as=table'
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

    should "display as table" do
      body.should have_element('table#gems')
      body.should have_element('table#gems tr.gem')
    end
  end

  describe 'getting gems/:name' do
    before do
      get '/gems/sinatra'
    end
    
    should "redirect to most recent version" do
      status.should.be.equal 302
    end
  end

  describe 'getting gems/name/version' do
    before do
      get '/gems/sinatra/0.9.0.4'
    end

    should "display only specific gem" do
      body.should.not have_element('.gem', /rack/)
    end

    should "display link to gems website" do
      body.should have_element('a', 'http://sinatra.rubyforge.org')
    end

    should "load gem spec specified version" do
      body.should have_element('.version', '0.9.0.4')
    end

    should "display links to all versions" do
      body.should have_element('.other_versions a[href="/gems/sinatra/"]')
    end
  end

end
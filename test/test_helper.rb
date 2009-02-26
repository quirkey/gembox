require 'rubygems'
require 'sinatra'
require 'sinatra/test/bacon'
require 'mocha'

require File.join(File.dirname(__FILE__), '..', 'gembox.rb')

require 'nokogiri'


module TestHelper
  
  def instance_of(klass)
    lambda {|obj| obj.is_a?(klass) }
  end
  
  # HTML matcher for bacon
  # 
  #    it 'should display document' do
  #      body.should have_element('#document')
  #    end
  #
  # With content matching:
  # 
  #    it 'should display loaded document' do
  #      body.should have_element('#document .title', /My Document/)
  #    end
  def have_element(search, content = nil)
    lambda do |obj|
      doc = Nokogiri.parse(obj.to_s)
      node_set = doc.search(search)
      if node_set.empty?
        false
      else
        collected_content = node_set.collect {|t| t.content }.join(' ')
        case content
        when Regexp
          collected_content =~ content
        when String
          collected_content.include?(content)
        when nil
          true
        end
      end
    end
  end


end

Bacon::Context.send(:include, TestHelper)


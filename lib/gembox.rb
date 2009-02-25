require 'active_support'

class ActiveSupport::OrderedHash
  def to_a
    a = []
    @keys.each do |key|
      a << [key, self[key]]
    end
    a
  end
end

module Gembox
  class Gems
    
    class << self
      attr_accessor :source_index
      
      def load
        @source_index ||= ::Gem.source_index
        local_gems
      end
      
      def local_gems
        @local_gems ||= group_gems(source_index.gems)
      end
      
      def search(search_term, version = nil)
        version = version ? Gem::Requirement.create(version) : Gem::Requirement.default
        gems = source_index.search Gem::Dependency.new(/^#{Regexp.escape(search_term)}/, version)
        group_gems(gems)
      end
      
      protected
      def group_gems(gem_collection)
        gem_hash = ActiveSupport::OrderedHash.new {|h,k| h[k] = [] }
        gem_collection = gem_collection.values if gem_collection.is_a?(Hash)
        gem_collection.each do |spec|
          gem_hash[spec.name] << spec
          gem_hash[spec.name].sort! {|a,b| (b.version || 0) <=> (a.version || 0) }
        end
        gem_hash.keys.sort! {|a,b| a.downcase <=> b.downcase}
        gem_hash
      end
    end
    
  end
end
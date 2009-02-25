module Gembox
  class Gems
    
    class << self
      attr_accessor :source_index
      
      def load
        @source_index ||= ::Gem.source_index
        local_gems
      end
      
      def local_gems
        @local_gems ||= group_gems
      end
      
      protected
      def group_gems
        gem_hash = Hash.new {|h,k| h[k] = [] }
        source_index.gems.each do |gem_with_version, spec|
          gem_hash[spec.name] << spec
        end
        gem_hash
      end
    end
    
  end
end
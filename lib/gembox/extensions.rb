module Gem
  class Specification

    def files_tree
      tree = {}
      files.each do |file|
        split_dirs = file.split(/\//)
        keyed_hash = {}
        split_dirs.reverse.each do |key|
          keyed_hash = {key => keyed_hash}
        end
        tree.deep_merge!(keyed_hash)
      end
      tree
    end
    
    def on_github?
      homepage =~ /github\.com\/([\w\d\-\_]+)\/([\w\d\-\_]+)\/tree/
    end
    
    alias :has_rdoc_checked? :has_rdoc?
    def has_rdoc?
      has_rdoc_checked? && File.exists?(rdoc_path)
    end
    
    def rdoc_path
      File.join(installation_path, 'doc', full_name, 'rdoc')
    end
  end
end
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
  end
end
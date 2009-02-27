module Gembox

  class GemList < Array
    
    def [](*args)
      if args.first.is_a?(String)
        search(args.first)
      else
        super
      end
    end
    
    def []=(key, value)
      if key.is_a?(String)
        if versions = search(key)
          versions.replace([key, value])
        else
          self << [key, value]
        end
      else
        super
      end
    end
    
    def search(key)
      i = find {|v| 
        if v.is_a?(Array)
          v[0] == key
        else
          v == key
        end
      }
      i.is_a?(Array) ? i[1] : i
    end
    
    def has_key?(key)
      !search(key).nil?
    end
  end
  
end
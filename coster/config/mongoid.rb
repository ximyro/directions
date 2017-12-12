require 'mongoid'
Mongoid.raise_not_found_error = false
Mongoid.load! "mongoid.yml", :default
unless Cost.collection.indexes.collection.count.zero?
  Cost.create_indexes
end

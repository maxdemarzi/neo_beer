require 'neography'
require 'neography/tasks'

namespace :neo4j do
  task :create do
    neo = Neography::Rest.new(ENV['NEO4J_URL'] || "http://localhost:7474")
    neo.create_node_index("node_auto_index", "fulltext")
  end
end
require 'bundler'
Bundler.require(:default, (ENV["RACK_ENV"]|| 'development').to_sym)

require 'sinatra/base'

class App < Sinatra::Base
  
  configure :development do |config|
    register Sinatra::Reloader
  end
  
  set :haml, :format => :html5 
  set :app_file, __FILE__

  get '/' do
    @neoid = params["neoid"]
    haml :index
  end
  
  get '/search' do 
    content_type :json
    neo = Neography::Rest.new    

    cypher = "START me=node:node_auto_index({query}) 
              RETURN ID(me), me.name?
              ORDER BY me.name?
              LIMIT 15"

    neo.execute_query(cypher, {:query => "name:*#{params[:term]}*" })["data"].map{|x| { label: x[1], value: x[0]}}.to_json   
  end

  get '/edges/:id' do
    content_type :json
    neo = Neography::Rest.new    

    cypher = "START me=node(#{params[:id]}) 
              MATCH me -- related
              RETURN ID(me), me.name, me.name as description, me.type, ID(related), related.name, related.name as description, related.type"

    connections = neo.execute_query(cypher)["data"]   
    connections.collect{|n| {"source" => n[0], "source_data" => {:label => n[1], 
                                                                 :description => n[2],
                                                                 :type => n[3] },
                             "target" => n[4], "target_data" => {:label => n[5], 
                                                                 :description => n[6],
                                                                 :type => n[7]}} }.to_json
  end
end
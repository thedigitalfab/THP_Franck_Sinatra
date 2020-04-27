require 'bundler'
Bundler.require

require './models/gossip'

class ApplicationController < Sinatra::Base
    get '/' do
        erb :index, locals: {gossips: Gossip.all}
    end

    get '/gossips/new/' do
        erb :new_gossip
    end

    post '/gossips/new/' do
        Gossip.new("#{params["gossip_author"]}", "#{params["gossip_content"]}").save
        redirect '/'
    end

    get '/gossips/:id/' do
        erb :gossip_view, locals: {gossip: Gossip.find(params["id"])}
    end

    get '/gossips/:id/edit' do
        erb :gossip_edit, locals: {gossip: Gossip.find(params["id"])}
    end

    post '/gossips/:id/edit' do
        # erb :gossip_edit, locals: {gossip: Gossip.find(params["id"])}
        Gossip.update(params["id"], params["gossip_author"], params["gossip_content"])
        #Gossip.new("#{params["gossip_author"]}", "#{params["gossip_content"]}").save
        redirect "/gossips/#{params["id"]}/"
    end
end
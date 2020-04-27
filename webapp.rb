require 'bundler'
Bundler.require

require './controllers/controller'

class ApplicationController < Sinatra::Base
    set :views, File.dirname(__FILE__) + '/views'
    set :public_folder, File.dirname(__FILE__) + '/public'
end
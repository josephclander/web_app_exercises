# frozen_string_literal: false

# file: app.rb
require 'sinatra/base'
require 'sinatra/reloader'

# This allows the app code to refresh
# without having to restart the server.
class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  # Declares a route that responds to a request with:
  #  - a GET method
  #  - the path /
  get '/' do
    # The code here is executed when a request is received,
    # and need to send a response.

    # We can simply return a string which
    # will be used as the response content.
    # Unless specified, the response status code
    # will be 200 (OK).
    return 'This is the homepage.'
  end

  get '/hello' do
    return erb(:index)
    # url => http://localhost:9292/example?name=Joe
    # response => Hello Joe
  end

  post '/submit' do
    name = params[:name]
    message = params[:message]
    "Thanks #{name}, you sent this message: '#{message}'"
  end

  get '/names' do
    list = params[:list]
    return list
  end

  get '/sorted-names' do
    names = params[:names]
    names.split(',').sort.join(',')
  end
end

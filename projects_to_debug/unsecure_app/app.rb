require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/hello' do
    @name = params[:name]
    return erb(:hello) if @name.gsub(/[^A-Za-z\s]/, '') == @name

    status 400
    'Invalid input'
  end
end

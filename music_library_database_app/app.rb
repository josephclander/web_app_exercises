# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums' do
    repo = AlbumRepository.new
    result_set = repo.all

    list = result_set.map do|album|
      album.title
    end
    list.join(', ')
  end

  post '/albums' do
    repo = AlbumRepository.new
    album = Album.new
    album.title = params[:title]
    album.release_year = params[:release_year]
    album.artist_id = params[:artist_id]

    repo.create(album)
  end

  get '/artists' do
    repo = ArtistRepository.new
    result_set = repo.all

    artists = result_set.map do |artist|
      artist.name
    end
    artists.join(', ')
  end

  post '/artist' do
    repo = ArtistRepository.new
    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]
    repo.create(artist)
  end
end

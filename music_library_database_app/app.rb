# file: app.rb
require 'sinatra'
require 'sinatra/reloader'
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

  get '/' do
    return erb(:index)
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all

    return erb(:albums)
  end

  get '/albums/new' do
    erb(:new_album)
  end

  get '/albums/:id' do
    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new
    @album = repo.find(params[:id].to_i)
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album)
  end

  post '/albums' do
    if invalid_album_params?
      status 400
      return erb(:album_failure)
    end
    repo = AlbumRepository.new
    album = Album.new
    album.title = params[:title]
    album.release_year = params[:release_year]
    album.artist_id = params[:artist_id]

    repo.create(album)

    return erb(:album_success)
  end

  def invalid_album_params?
    params[:title] == '' || params[:release_year] == '' || params[:artist_id] == ''
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all

    return erb(:artists)
  end

  get '/artists/:id' do
    repo = ArtistRepository.new
    @artist = repo.find(params[:id])

    return erb(:artist)
  end

  get '/artist/new' do
    erb(:new_artist)
  end

  post '/artist' do
    if invalid_artist_params?
      status 400
      return erb(:artist_failure)
    end
    repo = ArtistRepository.new
    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]

    repo.create(artist)

    return erb(:artist_success)
  end

  def invalid_artist_params?
    params[:name] == '' || params[:genre] == ''
  end
end

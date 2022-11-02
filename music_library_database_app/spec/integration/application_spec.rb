require 'spec_helper'
require 'rack/test'
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET albums' do
    it 'returns all albums' do
      response = get('/albums')

      expect(response.status).to eq 200
      expect(response.body).to include('Title: <a href="/albums/2">Surfer Rosa</a>')
      expect(response.body).to include('Released: 1988')
      expect(response.body).to include('Title: <a href="/albums/3">Waterloo</a>')
      expect(response.body).to include('Released: 1974')
    end
  end

  context 'GET album by id' do
    it 'returns an album' do
      response = get('/albums/2')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end
  end

  context 'POST /albums' do
    it 'returns a success page' do
      response = post(
        '/albums',
        title: 'Voyage',
        release_year: '2022',
        artist_id: 2
      )

      expect(response.status).to eq 200
      expect(response.body).to include('<p>Album successfully added</p>')
    end

    it 'responds with 400 status if parameters are invalid' do
      response = post(
        '/albums',
        title: '',
        release_year: '2022',
        artist_id: 2
      )
      expect(response.status).to eq 400
      expect(response.body).to include('<p>Album creation failure: Invalid input</p>')
    end
  end

  context 'GET /albums/new' do
    it 'returns a form page' do
      response = get('/albums/new')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Add an Album</h1>')
    end
  end

  context 'GET artist by id' do
    it 'returns a given artist' do
      response = get('/artists/1')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Artist: Pixies</h1>')
      expect(response.body).to include('<p>Genre: Rock</p>')
    end
  end

  context 'GET artists' do
    it 'returns all artists' do
      response = get('/artists')

      expect(response.status).to eq 200
      expect(response.body).to include("Artist: <a href='/artists/1'>Pixies</a>")
      expect(response.body).to include('Genre: Rock')
      expect(response.body).to include("Artist: <a href='/artists/2'>ABBA</a>")
      expect(response.body).to include('Genre: Pop')
      expect(response.body).to include("Artist: <a href='/artists/3'>Taylor Swift</a>")
      expect(response.body).to include('Genre: Pop')
      expect(response.body).to include("Artist: <a href='/artists/4'>Nina Simone</a>")
      expect(response.body).to include('Genre: Pop')
      expect(response.body).to include("Artist: <a href='/artists/5'>Kiasmos</a>")
      expect(response.body).to include('Genre: Experimental')
    end
  end

  context 'GET /artist/new' do
    it 'returns a form page' do
      response = get('/artist/new')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Add an Artist</h1>')
    end
  end

  context 'POST /artist' do
    it 'returns a success page' do
      response = post('/artist', name: 'Wild nothing', genre: 'Indie')

      expect(response.status).to eq 200
      expect(response.body).to include('<p>Artist successfully added</p>')
    end

    it 'responds with 400 status if parameters are invalid' do
      response = post(
        '/artist',
        name: '',
        genre: '2022'
      )
      expect(response.status).to eq 400
      expect(response.body).to include('<p>Artist creation failure: Invalid input</p>')
    end
  end
end

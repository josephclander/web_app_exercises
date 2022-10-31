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
      expect(response.body).to eq 'Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'
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

  context 'POST albums' do
    it 'creates a new album' do
      response = post('/albums', title: 'Voyage', release_year: '2022', artist_id: 2)
      result_set = get('/albums')
      expected_result = result_set.body.split(', ').last
      expect(response.status).to eq 200
      expect(expected_result).to eq 'Voyage'
    end
  end

  context 'GET artists' do
    it 'returns all artists' do
      response = get('/artists')

      expect(response.status).to eq 200
      expect(response.body).to eq 'Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos'
    end
  end

  context 'POST artist' do
    it 'creates an artist' do
      response = post('/artist', name: 'Wild nothing', genre: 'Indie')

      expect(response.status).to eq 200

      result_set = get('/artists')
      expect(result_set.body).to eq 'Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos, Wild nothing'
    end
  end
end

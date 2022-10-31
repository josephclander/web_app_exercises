require 'spec_helper'
require 'rack/test'
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET to /' do
    it 'returns 200 OK with the right content' do
      # Send a GET request to /
      # and returns a response object we can test.
      response = get('/')

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq('This is the homepage.')
    end
  end

  context 'GET to /hello' do
    it 'returns 200 OK with the right content' do
      # Send a GET request to /
      # and returns a response object we can test.
      response = get('/hello')

      # Assert the response status code and body.
      # expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Hello</h1>')
    end
  end

  context 'POST to /submit' do
    it 'returns 200 OK with the right content' do
      # Send a POST request to /submit
      # with some body parameters
      # and returns a response object we can test.
      response = post('/submit', name: 'Leo', message: 'Open your eyes!')

      # Assert the response status code and body.
      expected_response = "Thanks Leo, you sent this message: 'Open your eyes!'"
      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end
  end

  context 'GET /names' do
    it 'returns 200 OK' do
      response = get('/names', list: 'Julia, Mary, Karim')
      expected_response = 'Julia, Mary, Karim'
      expect(response.status).to eq 200
      expect(response.body).to eq expected_response
    end
  end

  context 'GET /sorted-names' do
    it 'returns 200 OK' do
      response = get('/sorted-names', names: 'Joe,Alice,Zoe,Julia,Kieran')
      expected_response = 'Alice,Joe,Julia,Kieran,Zoe'
      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end
  end
end

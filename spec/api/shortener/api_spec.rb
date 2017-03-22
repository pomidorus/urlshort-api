require 'rails_helper'

describe Shortener::API, type: :request do
  describe 'POST /' do
    let(:url) { 'http://www.farmdrop.com' }

    it 'creates short url' do
      post '/',  params: { url: url }
      hash_response = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(hash_response['url']).to eq(url)
      expect(hash_response['short_url']).to eq(Url.last.short_url)
    end
  end
end

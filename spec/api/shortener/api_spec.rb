require 'rails_helper'

describe Shortener::API, type: :request do
  let(:url) { 'http://www.farmdrop.com' }

  describe 'POST /' do
    context 'with valid url' do
      it 'creates short url' do
        post '/',  params: { url: url }
        hash_response = JSON.parse(response.body)

        expect(response.status).to eq(201)
        expect(hash_response['url']).to eq(url)
        expect(hash_response['short_url']).to eq(Url.last.short_url)
      end
    end
  end

  describe 'GET /:short_url' do
    before do
      @url_record = Url.create!({url: url})
      @url_record.short_url = ShortenerLib.bijective_encode(@url_record.id)
      @url_record.save!
    end

    context 'when url in the database' do
      it 'returns valid response' do
        get "/#{@url_record.short_url}"
        hash_response = JSON.parse(response.body)

        expect(response.status).to eq(301)
        expect(hash_response['url']).to eq(url)
      end
    end

    context 'when url is not in the database' do
      it 'returns error' do
        get "/abc"
        hash_response = JSON.parse(response.body)

        expect(response.status).to eq(400)
        expect(hash_response['error']).to eq('short_url is not found in the database')
      end
    end
  end
end

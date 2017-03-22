require 'rails_helper'

describe Shortener::API, type: :request do
  let(:url) { 'http://www.farmdrop.com' }

  describe 'POST /' do
    it 'creates short url' do
      post '/',  params: { url: url }
      hash_response = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(hash_response['url']).to eq(url)
      expect(hash_response['short_url']).to eq(Url.last.short_url)
    end
  end

  describe 'GET /:short_url' do
    before do
      @url_record = Url.create!({url: url})
      @url_record.short_url = ShortenerLib.bijective_encode(@url_record.id)
      @url_record.save!
    end

    it 'ddd' do
      get "/#{@url_record.short_url}"

      p response.body
      expect(response.status).to eq(403)
    end
  end
end

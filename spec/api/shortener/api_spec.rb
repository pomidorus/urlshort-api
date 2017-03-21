require 'rails_helper'

describe Shortener::API, type: :request do
  describe 'POST /' do
    it 'creates short url' do
      post "/",  params: { url: 'http://www.farmdrop.com'  }
      expect(response.status).to eq(201)
      p response.body
    end
  end
end

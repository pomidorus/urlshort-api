module Shortener
  class API < Grape::API
    format :json

    desc 'Welcome to our wonderful API'
    get '/' do
      { message: 'Welcome to our wonderful API' }
    end

    desc 'Create short url'
    params do
      requires :url, type: String, desc: 'URL for shortening'
    end
    post '/' do
      ShortenerService.new(params[:url]).generate
    end
  end
end

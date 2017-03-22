module Shortener
  class API < Grape::API
    format :json

    desc 'Welcome to our wonderful API'
    get '/' do
      { message: 'Welcome to our wonderful API' }
    end

    desc 'Redirect to posted URL'
    get '/:short_url' do
      status 403
      UrlDecoderService.new(params[:short_url]).decode
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

module Shortener
  class API < Grape::API
    format :json

    desc 'Welcome to our wonderful API'
    get '/' do
      { message: 'Welcome to our wonderful API' }
    end

    desc 'Redirect to posted URL'
    get '/:short_url' do
      result = UrlDecoderService.new(params[:short_url]).decode
      if result.present?
        status 403
        header 'Location', result['url']

        result
      else
        status 400
        { error: 'short_url is not found in the database' }
      end
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

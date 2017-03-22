class ShortenerService
  PROTOCOL_REG = /^(.*):\/\//
  URL_REGEX = /\b((https?):\/\/([\w\.-]+[\.]\w+)?)([-A-Z0-9+&@#\/%?=~_|$!:,.;]*[-A-Z0-9+&@#\/%=~_|$])?/i

  attr_reader :url

  def initialize(url)
    @url = assume_http(url)
  end

  def generate
    if valid_url?(@url)
      url_record = Url.create!({url: @url})
      url_record.short_url = ShortenerLib.bijective_encode(url_record.id)
      url_record.save!

      UrlPresenter.generate(url_record)
    else
      status 400
    end
  end

  private

  def assume_http(url)
    url = "http://#{url}" unless PROTOCOL_REG.match(url)
    url
  end

  def valid_url?(url)
    URL_REGEX.match(url)
  end
end

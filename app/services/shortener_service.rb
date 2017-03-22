class ShortenerService
  PROTOCOL_REG = %r{^(.*)://}

  attr_reader :url

  def initialize(url)
    @url = assume_http(url)
  end

  def generate
    url_record = Url.create!({url: @url})
    url_record.short_url = ::ShortenerLib.bijective_encode(url_record.id)
    url_record.save!

    UrlPresenter.generate(url_record)
  end

  private

  def assume_http(url)
    url = "http://#{url}" unless PROTOCOL_REG.match(url)
    url
  end
end

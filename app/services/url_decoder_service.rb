class UrlDecoderService
  def initialize(short_url)
    @short_url = short_url
  end

  def decode
    if url_present?(@short_url)
      UrlPresenter.short(@url_record)
    else
      status 400
      { error: 'short_url is not found in the database' }
    end
  end

  private

  def url_present?(short_url)
    @url_record = Url.where(short_url: short_url).first
    !@url_record.nil?
  end
end

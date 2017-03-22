class UrlDecoderService
  def initialize(short_url)
    @short_url = short_url
  end

  def decode
    UrlPresenter.short(@url_record) if url_present?(@short_url)
  end

  private

  def url_present?(short_url)
    @url_record = Url.where(short_url: short_url).first
    !@url_record.nil?
  end
end

class UrlPresenter
  def self.generate(url_record)
    { url: url_record.url, short_url: url_record.short_url }
  end
end

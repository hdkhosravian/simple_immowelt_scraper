require 'open-uri'

class Scraper
  attr_accessor :url, :doc

  def initialize(url)
    @url = url
  end

  def process
    scrape_from_url
    result = DataCollector.new(doc).process
    result
  end

  private

  def scrape_from_url
    @doc = Nokogiri::HTML(URI.open(url))
  end
end
require 'nokogiri'
require 'open-uri'

class WebsiteMetadata
  attr_reader :url, :title, :description

  def initialize(url)
    @url = url
    set_metadata
  end

  private

  def set_metadata
    begin
      website = get_website
      @title = find_title(website)
      @description = find_description(website)
    rescue OpenURI::HTTPError
      raise WebsiteMetadata::WebsiteNotFound
    end
  end

  def get_website
    Nokogiri::HTML(open(url))
  end

  def find_title(website)
    website.xpath('/html/head/title')&.text
  end

  def find_description(website)
    website.xpath('/html/head/meta[@name="Description"]/@content')&.to_s
  end

  class WebsiteNotFound < StandardError; end
end

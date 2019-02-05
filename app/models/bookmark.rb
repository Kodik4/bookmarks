class Bookmark < ApplicationRecord
  acts_as_taggable
  self.per_page = 10

  belongs_to :domain, optional: true

  validates :url,
    presence: true,
    format: URI::regexp(%w(http https)),
    uniqueness: true

  before_create :connect_with_domain, :set_metadata, :set_url_shortcut

  def self.search_by(words_string)
    words_arr = words_string.split(/\s+/).map { |word| Bookmark.like_sanitize(word) }
    arel_table = self.arel_table
    self.joins(:tags, :domain).where(
      arel_table[:name].matches_any(words_arr)
      .or(arel_table[:url].matches_any(words_arr))
    )
  end
  
  private

  def connect_with_domain
    domain = Domain.find_or_create_by(name: domain_with_www)
    self.domain = domain
  end

  def set_metadata
    begin
      website_metadata = WebsiteMetadata.new(url)
      self.metadata_title = website_metadata.title
      self.metadata_description = website_metadata.description
    rescue WebsiteMetadata::WebsiteNotFound
      errors.add(:url, 'is incorrect. Website does not exist.')
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def set_url_shortcut
    chars = ('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a
    random_chars = (1..15).map{ chars[rand(chars.size)] }.join
    loop do
      url_shortcut = domain_with_www << '/' << random_chars
      next if self.class.where(url_shortcut: url_shortcut).present?
      self.url_shortcut = url_shortcut
      break
    end
  end

  def domain_with_www
    domain_name = URI.parse(url).host
    domain_name.prepend('www.') unless domain_name.start_with?('www.')
    domain_name
  end
end

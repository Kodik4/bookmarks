class Bookmark < ApplicationRecord
  acts_as_taggable

  belongs_to :domain, optional: true

  validates :url,
    presence: true,
    format: URI::regexp(%w(http https)),
    uniqueness: true

  before_create :connect_with_domain, :set_metadata


  private

  def connect_with_domain
    domain_name = URI.parse(url).host
    domain_name.prepend('www.') unless domain_name.start_with?('www.')
    domain = Domain.find_or_create_by(name: domain_name)
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
end

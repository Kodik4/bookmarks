class Bookmark < ApplicationRecord
  acts_as_taggable

  belongs_to :domain, optional: true

  validates :url,
    presence: true,
    format: URI::regexp(%w(http https))

  before_create :connect_with_domain, :set_metadata


  private

  def connect_with_domain
    domain_name = URI.parse(url).host
    domain_name.prepend('www.') unless domain.start_with?('www.')
    domain = Domain.find_or_create_by(name: domain_name)
    self.domain = domain
  end

  def set_metadata
    #TODO
    # binding.pry
  end
end

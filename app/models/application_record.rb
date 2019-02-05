class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.like_sanitize(string)
    "%#{string.gsub('%', '\\%').gsub("'", "''")}%"
  end
end

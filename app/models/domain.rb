class Domain < ApplicationRecord
  has_many :bookmarks, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end

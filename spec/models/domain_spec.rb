require 'rails_helper'

RSpec.describe Domain, type: :model do
  it { should have_many(:bookmarks).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end

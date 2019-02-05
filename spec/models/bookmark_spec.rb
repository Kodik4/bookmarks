require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  it { should belong_to(:domain) }

  it { should validate_presence_of(:url) }
end

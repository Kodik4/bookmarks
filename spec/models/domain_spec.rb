require 'rails_helper'

RSpec.describe Domain, type: :model do
  it { should have_many(:bookmarks) }
end

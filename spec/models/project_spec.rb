require_relative './spec_setup'

RSpec.describe Project do
  it { is_expected.to have_many(:fields).inverse_of(:project) }
  it { is_expected.to have_many(:issues).inverse_of(:project) }
  it { is_expected.to have_many(:rules).inverse_of(:project) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:fields) }
end

require 'models/spec_setup'

RSpec.shared_examples 'field' do
  it { is_expected.to have_readonly_attribute(:project_id) }

  it { is_expected.to belong_to(:project).inverse_of(:fields) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:project) }

  it { is_expected.to delegate_method(:value_column).to(:class) }

  describe '.value_column' do
    it 'equals value column name' do
      expect(described_class.value_column).to eq(value_column)
    end
  end
end

require 'models/spec_setup'

describe Query do
  it { is_expected.to have_readonly_attribute(:project_id) }
  it { is_expected.to have_readonly_attribute(:identifier) }
  it { is_expected.to have_readonly_attribute(:constraint_type) }
  it { is_expected.to have_readonly_attribute(:constraint_id) }
  
  it { is_expected.to belong_to(:project) }
  it { is_expected.to belong_to(:constraint) }
  
  it { is_expected.to validate_presence_of(:project) }
  it { is_expected.to validate_presence_of(:constraint) }

  it { is_expected.to validate_uniqueness_of(:identifier) }
  it { is_expected.to validate_inclusion_of(:constraint_type).in_array(%w(Clause Condition)) }
  
  describe '#description' do
    it 'is present' do
      expect(model.description).to be_present
    end
  end
end

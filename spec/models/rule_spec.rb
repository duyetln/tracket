require_relative './spec_setup'

RSpec.describe Rule do
  it { is_expected.to have_readonly_attribute(:project_id) }
  it { is_expected.to have_readonly_attribute(:assertion_type) }
  it { is_expected.to have_readonly_attribute(:assertion_id) }
  it { is_expected.to have_readonly_attribute(:prerequisite_type) }
  it { is_expected.to have_readonly_attribute(:prerequisite_id) }

  it { is_expected.to belong_to(:project).inverse_of(:rules) }
  it { is_expected.to belong_to(:assertion) }
  it { is_expected.to belong_to(:prerequisite) }

  it { is_expected.to validate_presence_of(:project) }
  it { is_expected.to validate_presence_of(:assertion) }
  it { is_expected.to validate_inclusion_of(:assertion_type).in_array(%w(Clause Condition)) }

  context 'prerequisite present' do
    let(:subject) { FactoryGirl.build :rule, :prerequisite }
    before(:each) { expect(subject.prerequisite).to be_present }

    it { is_expected.to validate_inclusion_of(:prerequisite_type).in_array(%w(Clause Condition)) }
  end

  describe '#description' do
    it 'is present' do
      expect(model.description).to be_present
    end
  end
end

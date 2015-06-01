require 'models/spec_setup'

describe Junction do
  let :model do
    described_class.new parent_clause: FactoryGirl.build(:and_clause)
  end

  it { is_expected.to have_readonly_attribute :clause_id }
  it { is_expected.to have_readonly_attribute :condition_id }

  it { is_expected.to belong_to(:parent_clause).class_name('Clause').inverse_of(:junctions) }
  it { is_expected.to belong_to(:clause) }
  it { is_expected.to belong_to(:condition) }

  context 'clause present' do
    before :each do
      model.clause = FactoryGirl.build(:or_clause)
    end

    it { is_expected.to validate_uniqueness_of(:clause_id).scoped_to(:parent_clause_id) }
  end

  context 'condition' do
    before :each do
      model.condition = FactoryGirl.build(:equal)
    end

    it { is_expected.to validate_uniqueness_of(:condition_id).scoped_to(:parent_clause_id) }
  end

  context 'circular reference' do
    let :subject do
      clause = FactoryGirl.build :and_clause
      described_class.new parent_clause: clause, clause: clause
    end

    it { is_expected.to_not be_valid }
  end
end

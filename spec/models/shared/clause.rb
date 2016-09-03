require 'models/spec_setup'

RSpec.shared_examples 'clause' do
  it { is_expected.to have_many(:junctions).with_foreign_key(:parent_clause_id).inverse_of(:parent_clause) }
  it { is_expected.to have_many(:clauses).through(:junctions) }
  it { is_expected.to have_many(:clauses).through(:junctions) }

  context 'nested clause with more than one layer' do
    let(:subject) { nested_clause }

    it { is_expected.to_not be_valid }
  end

  context 'insufficient clauses or conditions' do
    let(:subject) { insufficient_clause }

    context 'having only one clause' do
      before :each do
        subject.clauses = subject.clauses[0...1]
        subject.conditions.clear
        expect(subject.clauses.size).to eq(1)
        expect(subject.conditions.size).to eq(0)
      end

      it { is_expected.to_not be_valid }
    end

    context 'having only one condition' do
      before :each do
        subject.clauses.clear
        subject.conditions = subject.conditions[0...1]
        expect(subject.clauses.size).to eq(0)
        expect(subject.conditions.size).to eq(1)
      end

      it { is_expected.to_not be_valid }
    end
  end

  describe '#description' do
    it 'is present' do
      expect(model.description).to be_present
    end
  end
end

require 'models/spec_setup'

shared_examples 'clause' do
  it { is_expected.to have_readonly_attribute(:parent_id) }
  it { is_expected.to have_readonly_attribute(:inversed) }

  it { is_expected.to belong_to(:parent).class_name('Clause').inverse_of(:clauses) }
  it { is_expected.to have_many(:clauses).with_foreign_key(:parent_id).inverse_of(:parent) }
  it { is_expected.to have_many(:conditions).inverse_of(:clause) }

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

  context 'circular reference' do
    let(:subject) { circular_clause }

    it { is_expected.to_not be_valid }
  end

  describe '#description' do
    it 'is present' do
      expect(model.description).to be_present
    end
  end
end

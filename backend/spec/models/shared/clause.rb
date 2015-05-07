require 'models/spec_setup'

shared_examples 'clause' do
  it { is_expected.to have_readonly_attribute(:parent_id) }
  it { is_expected.to have_readonly_attribute(:inversed) }

  it { is_expected.to belong_to(:parent).class_name('Clause').inverse_of(:clauses) }
  it { is_expected.to have_many(:clauses).with_foreign_key(:parent_id).inverse_of(:parent) }
  it { is_expected.to have_many(:conditions).inverse_of(:clause) }

  context 'circular reference' do
    context 'at one level' do
      it { is_expected.to_not be_valid }
    end

    context 'at more than one levels' do
      it { is_expected.to_not be_valid }
    end
  end

  context 'insufficient clauses or conditions' do
    context 'having only one clause' do
      it { is_expected.to_not be_valid }
    end

    context 'having only one condition' do
      it { is_expected.to_not be_valid }
    end
  end
end

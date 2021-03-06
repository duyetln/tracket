require 'models/spec_setup'

RSpec.shared_examples 'condition' do
  it { is_expected.to have_readonly_attribute(:field_id) }
  it { is_expected.to have_readonly_attribute(:inversed) }

  it { is_expected.to belong_to(:field) }

  it { is_expected.to validate_presence_of(:field) }

  describe '#description' do
    it 'is present' do
      expect(model.description).to be_present
    end
  end

  describe '#satisfied?' do
    context 'not inversed' do
      it 'is true' do
        model.inversed = false
        expect(model.satisfied?(issue)).to eq(true)
      end
    end

    context 'inversed' do
      it 'is false' do
        model.inversed = true
        expect(model.satisfied?(issue)).to eq(false)
      end
    end
  end
end

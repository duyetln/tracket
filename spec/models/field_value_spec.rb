require_relative './spec_setup'

RSpec.describe FieldValue do
  shared_examples 'field value type' do
    let(:field) { FactoryGirl.build field_type }
    let(:model_args) { [:field_value, field: field] }
    let(:value_column) { field.value_column }

    describe '#value' do
      it 'is determined by field\'s value_column' do
        expect(model.value).to eq(model.send(value_column))
      end
    end

    describe '#value=' do
      it 'is determined by field\'s value_column' do
        expect { model.value = value }.to change { model.send(value_column) }.to(value)
      end
    end
  end

  it { is_expected.to have_readonly_attribute(:issue_id) }
  it { is_expected.to have_readonly_attribute(:field_id) }

  it { is_expected.to belong_to(:issue).inverse_of(:field_values).touch(true) }
  it { is_expected.to belong_to(:field) }

  it { is_expected.to validate_presence_of(:issue) }
  it { is_expected.to validate_presence_of(:field) }

  context 'string field value' do
    let(:field_type) { :string_field }
    let(:value) { rand_str }

    include_examples 'field value type'
  end

  context 'text field value' do
    let(:field_type) { :text_field }
    let(:value) { rand_str }

    include_examples 'field value type'
  end

  context 'integer field value' do
    let(:field_type) { :integer_field }
    let(:value) { rand_num }

    include_examples 'field value type'
  end

  context 'decimal field value' do
    let(:field_type) { :decimal_field }
    let(:value) { rand_num.to_f }

    include_examples 'field value type'
  end

  context 'datetime field value' do
    let(:field_type) { :date_time_field }
    let(:value) { DateTime.now }

    include_examples 'field value type'
  end

  context 'option field value' do
    let(:field_type) { :option_field }
    let(:value) { rand_num }

    include_examples 'field value type'
  end
end

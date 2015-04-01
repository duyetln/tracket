require 'models/spec_setup'

shared_examples 'field' do
  it { is_expected.to have_readonly_attribute(:project_id) }

  it { is_expected.to belong_to(:project).inverse_of(:fields) }
  it { is_expected.to have_many(:field_values).inverse_of(:field) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:project) }

  it { is_expected.to delegate_method(:value_column).to(:class) }

  describe '.value_column' do
    it 'equals value column name' do
      expect(described_class.value_column).to eq(value_column)
    end
  end
end

describe StringField do
  let(:value_column) { :string_value }

  it_behaves_like 'field'
end

describe TextField do
  let(:value_column) { :text_value }

  it_behaves_like 'field'
end

describe IntegerField do
  let(:value_column) { :integer_value }

  it_behaves_like 'field'
end

describe DecimalField do
  let(:value_column) { :decimal_value }

  it_behaves_like 'field'
end

describe DatetimeField do
  let(:value_column) { :datetime_value }

  it_behaves_like 'field'
end

describe OptionField do
  let(:value_column) { :option_value }

  it_behaves_like 'field'

  it { is_expected.to have_many(:options).inverse_of(:option_field) }
end

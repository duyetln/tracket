require_relative '../spec_setup'
require_relative '../shared/field'

RSpec.describe Field do
  describe OptionField do
    let(:value_column) { :option_value }

    it_behaves_like 'field'

    it { is_expected.to have_many(:options).inverse_of(:option_field) }
  end
end

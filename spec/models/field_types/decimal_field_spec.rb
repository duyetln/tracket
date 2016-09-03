require_relative '../spec_setup'
require_relative '../shared/field'

RSpec.describe Field do
  describe DecimalField do
    let(:value_column) { :decimal_value }

    it_behaves_like 'field'
  end
end

require 'models/spec_setup'
require 'spec/models/shared/field'

describe Field do
  describe DecimalField do
    let(:value_column) { :decimal_value }

    it_behaves_like 'field'
  end
end

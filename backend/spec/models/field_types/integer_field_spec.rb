require 'models/spec_setup'
require 'spec/models/shared/field'

describe Field do
  describe IntegerField do
    let(:value_column) { :integer_value }

    it_behaves_like 'field'
  end
end

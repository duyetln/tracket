require 'models/spec_setup'
require 'spec/models/shared/field'

describe Field do
  describe DateTimeField do
    let(:value_column) { :date_time_value }

    it_behaves_like 'field'
  end
end

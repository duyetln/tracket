require_relative '../spec_setup'
require_relative '../shared/field'

RSpec.describe Field do
  describe DateTimeField do
    let(:value_column) { :date_time_value }

    it_behaves_like 'field'
  end
end

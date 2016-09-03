require_relative '../spec_setup'
require_relative '../shared/field'

RSpec.describe Field do
  describe IntegerField do
    let(:value_column) { :integer_value }

    it_behaves_like 'field'
  end
end

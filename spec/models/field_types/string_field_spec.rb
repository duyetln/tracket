require_relative '../spec_setup'
require_relative '../shared/field'

RSpec.describe Field do
  describe StringField do
    let(:value_column) { :string_value }

    it_behaves_like 'field'
  end
end

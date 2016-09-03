require_relative '../spec_setup'
require_relative '../shared/field'

RSpec.describe Field do
  describe TextField do
    let(:value_column) { :text_value }

    it_behaves_like 'field'
  end
end

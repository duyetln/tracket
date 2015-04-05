require 'models/spec_setup'
require 'spec/models/shared/field'

describe Field do
  describe TextField do
    let(:value_column) { :text_value }

    it_behaves_like 'field'
  end
end

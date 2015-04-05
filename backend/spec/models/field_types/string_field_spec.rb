require 'models/spec_setup'
require 'spec/models/shared/field'

describe Field do
  describe StringField do
    let(:value_column) { :string_value }

    it_behaves_like 'field'
  end
end

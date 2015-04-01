module SpecHelpers
  module Models
    extend ActiveSupport::Concern

    included do
      let(:model_args) { [described_class.to_s.underscore.to_sym] }
      let(:model) { FactoryGirl.build(*model_args) }
      let(:subject) { model }
    end
  end
end

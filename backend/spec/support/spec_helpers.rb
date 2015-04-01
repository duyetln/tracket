module SpecHelpers
  module Common
    extend ActiveSupport::Concern

    included do
      let(:rand_str) { Faker::Lorem.words.join('') }
      let(:rand_num) { rand(1..50) }
    end
  end
end

module SpecHelpers
  module Models
    extend ActiveSupport::Concern
    include SpecHelpers::Common

    included do
      let(:model_args) { [described_class.to_s.underscore.to_sym] }
      let(:model) { FactoryGirl.build(*model_args) }
      let(:subject) { model }
    end
  end
end

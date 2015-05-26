require 'models/spec_setup'
require 'spec/models/shared/condition'

describe GreaterThanEqual do
  let(:project) { FactoryGirl.create :project }
  let(:field) { project.fields.find { |f| f.class == field_class } }
  let(:issue) { FactoryGirl.build :issue, project: project }
  let(:model) { described_class.new field: field, value: condition_value }

  before :each do
    issue[field] = issue_value
  end

  context 'integer field' do
    let(:field_class) { IntegerField }
    let(:condition_value) { rand_num }
    let(:issue_value) { condition_value + 1 }

    it_behaves_like 'condition'
  end

  context 'decimal field' do
    let(:field_class) { DecimalField }
    let(:condition_value) { rand_num.to_f }
    let(:issue_value) { condition_value + 1 }

    it_behaves_like 'condition'
  end

  context 'date time field' do
    let(:field_class) { DateTimeField }
    let(:condition_value) { DateTime.now }
    let(:issue_value) { condition_value + 1.second }

    it_behaves_like 'condition'
  end
end

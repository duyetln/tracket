require 'models/spec_setup'
require 'spec/models/shared/condition'

describe NotEqual do
  let(:project) { FactoryGirl.create :project }
  let(:field) { project.fields.find { |f| f.class == field_class } }
  let(:issue) { FactoryGirl.build :issue, project: project }
  let(:model) { described_class.new field: field, value: condition_value }

  before :each do
    issue[field] = issue_value
  end

  context 'string field' do
    let(:field_class) { StringField }
    let(:condition_value) { rand_str }
    let(:issue_value) { condition_value + '1' }

    it_behaves_like 'condition'
  end

  context 'text field' do
    let(:field_class) { TextField }
    let(:condition_value) { rand_str }
    let(:issue_value) { condition_value + '1' }

    it_behaves_like 'condition'
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

  context 'option field' do
    let(:field_class) { OptionField }
    let(:condition_value) { field.options.first.id }
    let(:issue_value) { field.options.last.id }

    it_behaves_like 'condition'
  end
end

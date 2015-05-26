require 'models/spec_setup'
require 'spec/models/shared/condition'

describe LessThan do
  let(:model) { FactoryGirl.build :less_than, *traits }
  let(:field) { model.field }
  let(:project) { field.project }
  let(:issue) { FactoryGirl.build :issue, project: project }

  before :each do
    issue[field] = issue_value
  end

  context 'integer field' do
    let(:traits) { [:integer_field] }
    let(:issue_value) { model.value - 1 }

    it_behaves_like 'condition'
  end

  context 'decimal field' do
    let(:traits) { [:decimal_field] }
    let(:issue_value) { model.value - 1 }

    it_behaves_like 'condition'
  end

  context 'date time field' do
    let(:traits) { [:date_time_field] }
    let(:issue_value) { model.value - 1.second }

    it_behaves_like 'condition'
  end
end

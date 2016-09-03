require_relative '../spec_setup'
require_relative '../shared/condition'

RSpec.describe NotEqual do
  let(:model) { FactoryGirl.build :not_equal, *traits }
  let(:field) { model.field }
  let(:project) { field.project }
  let(:issue) { FactoryGirl.build :issue, project: project }

  before :each do
    issue[field] = issue_value
  end

  context 'string field' do
    let(:traits) { [:string_field] }
    let(:issue_value) { model.value + '1' }

    it_behaves_like 'condition'
  end

  context 'text field' do
    let(:traits) { [:string_field] }
    let(:issue_value) { model.value + '1' }

    it_behaves_like 'condition'
  end

  context 'integer field' do
    let(:traits) { [:integer_field] }
    let(:issue_value) { model.value + 1 }

    it_behaves_like 'condition'
  end

  context 'decimal field' do
    let(:traits) { [:decimal_field] }
    let(:issue_value) { model.value + 1 }

    it_behaves_like 'condition'
  end

  context 'date time field' do
    let(:traits) { [:date_time_field] }
    let(:issue_value) { model.value + 1.second }

    it_behaves_like 'condition'
  end

  context 'option field' do
    let(:traits) { [:option_field] }
    let(:issue_value) { field.options.reject { |f| f.id == model.value }.sample.id }

    it_behaves_like 'condition'
  end
end

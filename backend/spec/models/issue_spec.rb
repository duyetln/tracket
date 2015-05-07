require 'models/spec_setup'

describe Issue do
  it { is_expected.to have_readonly_attribute(:project_id) }
  it { is_expected.to have_readonly_attribute(:number) }

  it { is_expected.to belong_to(:project).inverse_of(:issues) }
  it { is_expected.to have_many(:field_values).inverse_of(:issue) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:field_values) }

  it 'should validate uniqueness of :number scoped_to => :project_id' do
    issue = FactoryGirl.create :issue
    model.project = issue.project
    model.number = issue.number
    expect(model).to_not be_valid
  end

  it { is_expected.to delegate_method(:fields).to(:project) }

  context 'no field values' do
    let(:subject) { model }
    before(:each) { subject.field_values.clear }
    it { is_expected.to_not be_valid }
  end

  context 'duplicate field values' do
    let(:subject) { model }
    before(:each) { subject.field_values << FieldValue.new(field: subject.fields.sample) }
    it { is_expected.to_not be_valid }
  end

  context 'changing project' do
    let(:subject) { model }
    before (:each) { subject.project = FactoryGirl.build :project }
    it { is_expected.to_not be_valid }
  end

  describe '#[]=' do
    let(:project) { FactoryGirl.create :project }
    let(:model) { FactoryGirl.build :issue, project: project }
    let :field do
      model.fields.find do |f|
        f.class.name.underscore.to_sym == field_type
      end
    end

    shared_examples '#[]=' do
      shared_examples 'setting field value' do
        it 'sets field value correctly' do
          model[field] = value
          expect(
            model.field_values.find do |fv|
              fv.field == field
            end.value
          ).to eq(value)
        end
      end

      context 'new model' do
        before :each do
          expect(model).to be_new_record
        end

        include_examples 'setting field value'
      end

      context 'saved model' do
        before :each do
          expect(model.save!).to eq(true)
        end

        include_examples 'setting field value'
      end
    end

    context 'string field' do
      let(:field_type) { :string_field }
      let(:value) { rand_str }

      include_examples '#[]='
    end

    context 'text field' do
      let(:field_type) { :text_field }
      let(:value) { rand_str }

      include_examples '#[]='
    end

    context 'integer field' do
      let(:field_type) { :integer_field }
      let(:value) { rand_num }

      include_examples '#[]='
    end

    context 'decimal field' do
      let(:field_type) { :decimal_field }
      let(:value) { rand_num.to_f }

      include_examples '#[]='
    end

    context 'date_time_field' do
      let(:field_type) { :date_time_field }
      let(:value) { DateTime.now }

      include_examples '#[]='
    end

    context 'option_field' do
      let(:field_type) { :option_field }
      let(:value) { rand_num }

      include_examples '#[]='
    end
  end

  describe '#[]' do
    let(:project) { FactoryGirl.create :project }
    let(:model) { FactoryGirl.build :issue, project: project }
    let :field do
      model.fields.find do |f|
        f.class.name.underscore.to_sym == field_type
      end
    end

    shared_examples '#[]' do
      shared_examples 'getting field value' do
        it 'gets field value correctly' do
          model[field] = value
          expect(model[field]).to eq(value)
        end
      end

      context 'new model' do
        before :each do
          expect(model).to be_new_record
        end

        include_examples 'getting field value'
      end

      context 'saved model' do
        before :each do
          expect(model.save!).to eq(true)
        end

        include_examples 'getting field value'
      end
    end

    context 'string field' do
      let(:field_type) { :string_field }
      let(:value) { rand_str }

      include_examples '#[]'
    end

    context 'text field' do
      let(:field_type) { :text_field }
      let(:value) { rand_str }

      include_examples '#[]'
    end

    context 'integer field' do
      let(:field_type) { :integer_field }
      let(:value) { rand_num }

      include_examples '#[]'
    end

    context 'decimal field' do
      let(:field_type) { :decimal_field }
      let(:value) { rand_num.to_f }

      include_examples '#[]'
    end

    context 'date_time_field' do
      let(:field_type) { :date_time_field }
      let(:value) { DateTime.now }

      include_examples '#[]'
    end

    context 'option_field' do
      let(:field_type) { :option_field }
      let(:value) { rand_num }

      include_examples '#[]'
    end
  end
end

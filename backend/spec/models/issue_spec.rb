require 'models/spec_setup'

describe Issue do
  it { is_expected.to have_readonly_attribute(:project_id) }
  it { is_expected.to have_readonly_attribute(:number) }

  it { is_expected.to belong_to(:project).inverse_of(:issues) }
  it { is_expected.to have_many(:field_values).inverse_of(:issue).autosave(true) }

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

  context 'rules present', :no_db_clean do
    attr_reader :project

    let(:model) { FactoryGirl.build :issue, project: project }
    let(:string_field) { model.fields.find { |f| f.class == StringField } }
    let(:integer_field) { model.fields.find { |f| f.class == IntegerField } }
    before :each do
      project.rules.destroy_all
      project.rules << rule
    end

    before :all do
      @project = FactoryGirl.create :project
    end

    shared_examples 'checking rules' do
      context 'valid model' do
        before :each do
          model[string_field] = 'String field'
          expect(model.satisfied?(rule.assertion)).to eq(true)
        end

        it { is_expected.to be_valid }
      end

      context 'invalid model' do
        before :each do
          model[string_field] = nil
          expect(model.satisfied?(rule.assertion)).to eq(false)
        end

        it { is_expected.to_not be_valid }
      end
    end

    context 'prerequisite present' do
      let(:rule) { FactoryGirl.build :rule, :prerequisite, project: project }
      before(:each) { expect(rule.prerequisite).to be_present }

      context 'prerequisite satisfied' do
        before :each do
          model[integer_field] = 1
          expect(model.qualified?(rule)).to eq(true)
        end

        include_examples 'checking rules'
      end

      context 'prerequisite not satisfied' do
        before :each do
          model[integer_field] = 2
          expect(model.qualified?(rule)).to eq(false)
        end

        it { is_expected.to be_valid }
      end
    end

    context 'no prerequisite' do
      let(:rule) { FactoryGirl.build :rule, project: project }
      before(:each) { expect(rule.prerequisite).to_not be_present }

      include_examples 'checking rules'
    end
  end

  describe '#[]=', :no_db_clean do
    attr_reader :project

    let(:model) { FactoryGirl.build :issue, project: project }
    let :field do
      model.fields.find do |f|
        f.class.name.underscore.to_sym == field_type
      end
    end

    before :all do
      @project = FactoryGirl.create :project
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

  describe '#[]', :no_db_clean do
    attr_reader :project

    let(:model) { FactoryGirl.build :issue, project: project }
    let :field do
      model.fields.find do |f|
        f.class.name.underscore.to_sym == field_type
      end
    end

    before :all do
      @project = FactoryGirl.create :project
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

  describe '#modified?' do
    before :each do
      model.save!
    end

    context 'no change' do
      context 'checking any field' do
        it 'is false' do
          expect(model.modified?).to eq(false)
        end
      end

      context 'checking all fields' do
        it 'is false' do
          model.project.fields.each do |f|
            expect(model.modified?(f)).to eq(false)
          end
        end
      end
    end

    context 'existing change' do
      let(:project) { model.project }
      let(:field) { project.fields.find { |f| f.class == StringField } }
      let(:change) { rand_str }

      before :each do
        model[field] = change
      end

      context 'checking any field' do
        it 'is true' do
          expect(model.modified?).to eq(true)
        end
      end

      context 'checking changed field' do
        it 'is true' do
          expect(model.modified?(field)).to eq(true)
        end
      end

      context 'checking all other fields' do
        it 'is false' do
          project.fields.reject { |f| f == field }.each do |f|
            expect(model.modified?(f)).to eq(false)
          end
        end
      end
    end
  end
end

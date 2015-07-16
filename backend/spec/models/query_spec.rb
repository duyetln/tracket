require 'models/spec_setup'

describe Query do
  it { is_expected.to have_readonly_attribute(:project_id) }
  it { is_expected.to have_readonly_attribute(:identifier) }
  it { is_expected.to have_readonly_attribute(:constraint_type) }
  it { is_expected.to have_readonly_attribute(:constraint_id) }

  it { is_expected.to belong_to(:project) }
  it { is_expected.to belong_to(:constraint) }

  it { is_expected.to validate_presence_of(:project) }
  it { is_expected.to validate_presence_of(:constraint) }

  it { is_expected.to validate_uniqueness_of(:identifier) }
  it { is_expected.to validate_inclusion_of(:constraint_type).in_array(%w(Clause Condition)) }

  describe '#description' do
    it 'is present' do
      expect(model.description).to be_present
    end
  end

  describe '#issues' do
    attr_reader :project, :count
    attr_reader :string_field, :text_field, :integer_field, :decimal_field, :date_time_field, :option_field
    attr_reader :string_value, :text_value, :integer_value, :decimal_value, :date_time_value, :option_value

    def string_value; 'String Value'; end
    def text_value; 'Text Value'; end
    def integer_value; 1; end
    def decimal_value; 1.0; end
    def date_time_value; DateTime.new(1990,01,02); end
    def option_value; option_field.options.first.id; end

    before :all do
      @project = FactoryGirl.create :project
      @count = 3

      @string_field = project.fields.find { |f| f.class == StringField }
      @text_field = project.fields.find { |f| f.class == TextField }
      @integer_field = project.fields.find { |f| f.class == IntegerField }
      @decimal_field = project.fields.find { |f| f.class == DecimalField }
      @date_time_field = project.fields.find { |f| f.class == DateTimeField }
      @option_field = project.fields.find { |f| f.class == OptionField }

      @string_value = 'String Value'
      @text_value = 'Text Value'
      @integer_value = 1
      @decimal_value = 1.0
      @date_time_value = DateTime.new(1990,01,02)
      @option_value = @option_field.options.first.id

      {
        @string_field => @string_value,
        @text_field => @text_value,
        @integer_field => @integer_value,
        @decimal_field => @decimal_value,
        @date_time_field => @date_time_value,
        @option_field => @option_value
      }.each do |f,v|
        @count.times do
          issue = FactoryGirl.build :issue, project: @project
          issue[f] = v
          issue.save!
        end
      end
    end

    shared_examples 'query' do
      let(:model) { described_class.new(project: project, constraint: Equal.new(field: field, value: value)) }
      let(:issues) { model.issues(:all) }

      it 'retrieves issues correctly' do
        expect(issues.size).to eq(count)
        issues.each do |issue|
          expect(issue.satisfy?(model.constraint)).to eq(true)
        end
      end

      it 'counts issues correctly' do
        expect(model.issues(:count)).to eq(count)
      end
    end

    context 'single condition', :no_db_clean do
      context 'string field' do
        let(:field) { string_field }
        let(:value) { string_value }

        include_examples 'query'
      end

      context 'text field' do
        let(:field) { text_field }
        let(:value) { text_value }

        include_examples 'query'
      end

      context 'integer field' do
        let(:field) { integer_field }
        let(:value) { integer_value }

        include_examples 'query'
      end

      context 'decimal field' do
        let(:field) { decimal_field }
        let(:value) { decimal_value }

        include_examples 'query'
      end

      context 'date time field' do
        let(:field) { date_time_field }
        let(:value) { date_time_value }

        include_examples 'query'
      end

      context 'option field' do
        let(:field) { option_field }
        let(:value) { option_value }

        include_examples 'query'
      end
    end
  end
end

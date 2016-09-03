require_relative './spec_setup'

RSpec.describe Query do
  it { is_expected.to have_readonly_attribute(:project_id) }
  it { is_expected.to have_readonly_attribute(:identifier) }
  it { is_expected.to have_readonly_attribute(:criterion_type) }
  it { is_expected.to have_readonly_attribute(:criterion_id) }

  it { is_expected.to belong_to(:project) }
  it { is_expected.to belong_to(:criterion) }

  it { is_expected.to validate_presence_of(:project) }
  it { is_expected.to validate_presence_of(:criterion) }

  it { is_expected.to validate_uniqueness_of(:identifier) }
  it { is_expected.to validate_inclusion_of(:criterion_type).in_array(%w(Clause Condition)) }

  describe '#description' do
    it 'is present' do
      expect(model.description).to be_present
    end
  end

  describe '#issues', :no_db_clean do
    let(:issues) { model.issues(:all) }
    let(:model) { described_class.new(project: project, criterion: criterion) }

    attr_reader :project, :count
    attr_reader :string_field, :text_field, :integer_field, :decimal_field, :date_time_field, :option_field
    attr_reader :string_value, :text_value, :integer_value, :decimal_value, :date_time_value, :option_value

    def string_value
      'String Value'
    end

    def text_value
      'Text Value'
    end

    def integer_value
      1
    end

    def decimal_value
      1.0
    end

    def date_time_value
      DateTime.new(1990, 0o1, 0o2)
    end

    def option_value
      option_field.options.first.id
    end

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
      @date_time_value = DateTime.new(1990, 0o1, 0o2)
      @option_value = @option_field.options.first.id

      {
        @text_field => @text_value,
        @decimal_field => @decimal_value,
        @date_time_field => @date_time_value,
        @option_field => @option_value
      }.each do |f, v|
        @count.times do
          issue = FactoryGirl.build :issue, project: @project
          issue[f] = v
          issue[@string_field] = @string_value
          issue[@integer_field] = @integer_value
          issue.save!
        end
      end
    end

    shared_examples 'query' do
      it 'retrieves issues correctly' do
        expect(issues.size).to eq(expected_count)
        issues.each do |issue|
          expect(issue.satisfied?(model.criterion)).to eq(true)
        end
      end

      it 'counts issues correctly' do
        expect(model.issues(:count)).to eq(expected_count)
      end
    end

    context 'condition criterion' do
      let(:expected_count) { count }

      context 'string field' do
        let(:expected_count) { count * 4 }
        let(:criterion) { Equal.new field: string_field, value: string_value }

        include_examples 'query'
      end

      context 'text field' do
        let(:criterion) { Equal.new field: text_field, value: text_value }

        include_examples 'query'
      end

      context 'integer field' do
        let(:expected_count) { count * 4 }
        let(:criterion) { Equal.new field: integer_field, value: integer_value }

        include_examples 'query'
      end

      context 'decimal field' do
        let(:criterion) { Equal.new field: decimal_field, value: decimal_value }

        include_examples 'query'
      end

      context 'date time field' do
        let(:criterion) { Equal.new field: date_time_field, value: date_time_value }

        include_examples 'query'
      end

      context 'option field' do
        let(:criterion) { Equal.new field: option_field, value: option_value }

        include_examples 'query'
      end

      context 'impossible condition' do
        let(:expected_count) { 0 }
        let(:criterion) { Equal.new field: string_field, value: text_value }

        include_examples 'query'
      end
    end

    context 'clause criterion' do
      context 'and clause' do
        let(:expected_count) { count }
        let :criterion do
          criterion = AndClause.new
          criterion.conditions << Equal.new(field: string_field, value: string_value)
          criterion.conditions << Equal.new(field: decimal_field, value: decimal_value)
          criterion
        end

        include_examples 'query'
      end

      context 'or clause' do
        let(:expected_count) { count * 2 }
        let :criterion do
          criterion = OrClause.new
          criterion.conditions << Equal.new(field: date_time_field, value: date_time_value)
          criterion.conditions << Equal.new(field: option_field, value: option_value)
          criterion
        end

        include_examples 'query'
      end

      context 'disjunctive clause' do
        let(:expected_count) { count * 2 }
        let :criterion do
          and_clause = AndClause.new
          and_clause.conditions << Equal.new(field: string_field, value: string_value)
          and_clause.conditions << Equal.new(field: option_field, value: option_value)

          criterion = OrClause.new
          criterion.conditions << Equal.new(field: decimal_field, value: decimal_value)
          criterion.clauses << and_clause
          criterion
        end

        include_examples 'query'
      end

      context 'conjunctive clause' do
        let(:expected_count) { count }
        let :criterion do
          or_clause = OrClause.new
          or_clause.conditions << Equal.new(field: string_field, value: string_value)
          or_clause.conditions << Equal.new(field: option_field, value: option_value)

          criterion = AndClause.new
          criterion.conditions << Equal.new(field: date_time_field, value: date_time_value)
          criterion
        end

        include_examples 'query'
      end

      context 'impossible clause' do
        let(:expected_count) { 0 }
        let :criterion do
          criterion = AndClause.new
          criterion.conditions << NotEqual.new(field: string_field, value: string_value)
          criterion.conditions << NotEqual.new(field: integer_field, value: integer_field)
          criterion
        end

        include_examples 'query'
      end
    end
  end
end

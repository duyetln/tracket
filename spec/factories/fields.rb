FactoryGirl.define do
  factory :string_field do
    name 'String field'
    project { build :project }
  end

  factory :text_field do
    name 'Text field'
    project { build :project }
  end

  factory :integer_field do
    name 'Integer field'
    project { build :project }
  end

  factory :decimal_field do
    name 'Decimal field'
    project { build :project }
  end

  factory :date_time_field do
    name 'Datetime field'
    project { build :project }
  end

  factory :option_field do
    name 'Option field'
    project { build :project }

    after :build do |field|
      field.options << Option.new(name: 'Option 1')
      field.options << Option.new(name: 'Option 2')
      field.options << Option.new(name: 'Option 3')
    end
  end
end

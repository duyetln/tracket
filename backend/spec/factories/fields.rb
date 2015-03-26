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

  factory :datetime_field do
    name 'Datetime field'
    project { build :project }
  end

  factory :option_field do
    name 'Option field'
    project { build :project }
  end
end

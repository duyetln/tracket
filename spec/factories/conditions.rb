FactoryGirl.define do
  factory :condition do
    transient do
      project { create :project }
    end

    trait :inversed do
      inversed true
    end

    trait :string_field do
      field { project.fields.find { |f| f.class == StringField } }
      value { 'string field' }
    end

    trait :text_field do
      field { project.fields.find { |f| f.class == TextField } }
      value { 'text field' }
    end

    trait :integer_field do
      field { project.fields.find { |f| f.class == IntegerField } }
      value { 1 }
    end

    trait :decimal_field do
      field { project.fields.find { |f| f.class == DecimalField } }
      value { 1.0 }
    end

    trait :date_time_field do
      field { project.fields.find { |f| f.class == DateTimeField } }
      value { DateTime.now }
    end

    trait :option_field do
      field { project.fields.find { |f| f.class == OptionField } }
      value { field.options.sample.id }
    end

    factory :equal, class: Equal, traits: [:integer_field]
    factory :not_equal, class: NotEqual, traits: [:integer_field]
    factory :greater_than, class: GreaterThan, traits: [:integer_field]
    factory :greater_than_equal, class: GreaterThanEqual, traits: [:integer_field]
    factory :less_than, class: LessThan, traits: [:integer_field]
    factory :less_than_equal, class: LessThanEqual, traits: [:integer_field]
  end
end

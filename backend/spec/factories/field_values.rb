FactoryGirl.define do
  factory :field_value do
    transient do
      project { build :project, fields: [] }
    end

    issue { build :issue, project: project }
    field do
      build [
        :string_field,
        :text_field,
        :integer_field,
        :decimal_field,
        :datetime_field,
        :option_field
      ].sample,
      project: project
    end
  end
end

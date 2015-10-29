FactoryGirl.define do
  factory :rule do
    project { create :project }

    trait :prerequisite do
      prerequisite { build :equal, :integer_field, project: project }
    end

    assertion { build :not_equal, :string_field, project: project, value: nil }
  end
end

FactoryGirl.define do
  factory :issue do
    transient do
      project { build :project }
    end

    name 'Name'
    description 'Description'
    initialize_with { new project: project }
  end
end

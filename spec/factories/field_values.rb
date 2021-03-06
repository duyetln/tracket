FactoryGirl.define do
  factory :field_value do
    transient do
      project { create :project }
    end

    issue { build :issue, project: project }
    field { project.fields.sample }
  end
end

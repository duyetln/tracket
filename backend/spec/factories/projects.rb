FactoryGirl.define do
  factory :project do
    name 'Name'
    description 'Description'

    after :build do |project|
      project.fields << build(:string_field, project: nil)
      project.fields << build(:text_field, project: nil)
      project.fields << build(:integer_field, project: nil)
      project.fields << build(:decimal_field, project: nil)
      project.fields << build(:datetime_field, project: nil)
      project.fields << build(:option_field, project: nil)
    end
  end
end

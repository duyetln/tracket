FactoryGirl.define do
  factory :query do
    transient do
      shared_project { create :project }
    end

    trait :condition do
      criterion { build(:equal, project: shared_project) }
    end

    trait :clause do
      criterion { build(:and_clause, project: shared_project) }
    end

    project { shared_project }
    criterion { build(:equal, project: shared_project) }
  end
end

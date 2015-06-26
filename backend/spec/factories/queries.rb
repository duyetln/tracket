FactoryGirl.define do 
  factory :query do
    transient do
      shared_project { create :project }  
    end
    
    trait :condition do
      constraint { build(:equal, project: shared_project) }
    end
  
    trait :clause do
      constraint { build(:and_clause, project: shared_project) }
    end
    
    project { shared_project }
    constraint { build(:equal, project: shared_project) }
  end
end

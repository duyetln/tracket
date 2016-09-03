FactoryGirl.define do
  factory :clause do
    transient do
      project { create :project }
      field { project.fields.find { |f| f.class == IntegerField } }
      value { 1 }
      conditions do
        [
          build(:equal, field: field, value: value),
          build(:not_equal, field: field, value: value),
          build(:greater_than, field: field, value: value),
          build(:greater_than_equal, field: field, value: value),
          build(:less_than, field: field, value: value),
          build(:less_than_equal, field: field, value: value)
        ]
      end
    end

    trait :conditions do
      after :build do |clause, evaluator|
        evaluator.conditions.each do |condition|
          clause.conditions << condition
        end
      end
    end

    trait :clauses do
      after :build do |clause, evaluator|
        clause.clauses << build(:and_clause, conditions: evaluator.conditions)
        clause.clauses << build(:or_clause, conditions: evaluator.conditions)
      end
    end

    factory :and_clause, class: AndClause, traits: [:conditions]
    factory :or_clause, class: OrClause, traits: [:conditions]
  end
end

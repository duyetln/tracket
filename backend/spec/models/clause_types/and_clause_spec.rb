require 'models/spec_setup'
require 'spec/models/shared/clause'

describe AndClause do
  let(:model) { FactoryGirl.build :and_clause, :clauses }
  let(:insufficient_clause) { model }
  let :nested_clause do
    clause1 = FactoryGirl.build :and_clause, :clauses
    clause2 = FactoryGirl.build :or_clause, :clauses
    clause1.clauses << clause2
    clause1
  end


  it_behaves_like 'clause'
end

require 'models/spec_setup'
require 'spec/models/shared/clause'

describe OrClause do
  let(:model) { FactoryGirl.build :or_clause, :clauses }
  let(:insufficient_clause) { model }
  let :circular_clause do
    clause1 = FactoryGirl.build :or_clause
    clause2 = FactoryGirl.build :and_clause
    clause3 = FactoryGirl.build :or_clause
    clause1.parent = clause2
    clause2.parent = clause3
    clause3.parent = clause1
    clause1
  end


  it_behaves_like 'clause'
end

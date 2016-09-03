require_relative '../spec_setup'
require_relative '../shared/clause'

RSpec.describe OrClause do
  let(:model) { FactoryGirl.build :or_clause, :clauses }
  let(:insufficient_clause) { model }
  let :nested_clause do
    clause1 = FactoryGirl.build :or_clause, :clauses
    clause2 = FactoryGirl.build :and_clause, :clauses
    clause1.clauses << clause2
    clause1
  end

  it_behaves_like 'clause'
end

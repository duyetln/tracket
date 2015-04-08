require 'models/clause'

class OrClause < Clause
  def satisfy?(issue)
    conditions.any? { |c| c.satisfy?(issue) } ||
    clauses.any? { |c| c.satisfy?(issue) }
  end
end

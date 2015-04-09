require 'models/clause'

class OrClause < Clause
  def satisfy?(issue)
    flip(conditions.any? { |c| c.satisfy?(issue) } ||
    clauses.any? { |c| c.satisfy?(issue) })
  end
end

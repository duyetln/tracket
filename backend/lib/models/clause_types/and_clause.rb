require 'models/clause'

class AndClause < Clause
  def satisfy?(issue)
    flip(conditions.all? { |c| c.satisfy?(issue) } &&
    clauses.all? { |c| c.satisfy?(issue) })
  end
end

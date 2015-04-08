require 'models/clause'

class AndClause < Clause
  def satisfy?(issue)
    conditions.all? { |c| c.satisfy?(issue) } &&
    clauses.all? { |c| c.satisfy?(issue) }
  end
end

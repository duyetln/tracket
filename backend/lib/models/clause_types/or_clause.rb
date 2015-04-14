require 'models/clause'

class OrClause < Clause
  def satisfy?(issue)
    flip(conditions.any? { |c| c.satisfy?(issue) } ||
    clauses.any? { |c| c.satisfy?(issue) })
  end

  def arel_query
    issues = Arel::Table.new(:issues)
    select = issues.project(issues[:id].as('issue_id'))

    union = Arel::Nodes::TableAlias.new(arel_queries.reduce do |a,e|
      Arel::Nodes::Union.new(a, e)
    end, generate_table_alias)

    select.join(union).on(issues[:id].eq(union[:issue_id]))
  end
end

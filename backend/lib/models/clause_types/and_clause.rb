require 'models/clause'

class AndClause < Clause
  def satisfy?(issue)
    flip(conditions.all? { |c| c.satisfy?(issue) } &&
    clauses.all? { |c| c.satisfy?(issue) })
  end

  def arel_query
    issues = Arel::Table.new(:issues)
    select = issues.project(issues[:id].as('issue_id'))

    select.tap do |s|
      arel_queries.each do |query|
        table = Arel::Nodes::TableAlias.new(query, generate_table_alias)
        s.join(table).on(issues[:id].eq(table[:issue_id]))
      end
    end
  end
end

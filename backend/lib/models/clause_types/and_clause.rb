require 'models/clause'

class AndClause < Clause
  def satisfied?(issue)
    conditions.all? { |c| c.satisfied?(issue) } &&
    clauses.all? { |c| c.satisfied?(issue) }
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

  def description
    cond_desc = conditions.map(&:description).join(' AND ')
    clse_desc = clauses.map(&:description).map { |desc| "(#{desc})" }.join(' AND ')
    [cond_desc, clse_desc].select(&:present?).join(' AND ')
  end
end

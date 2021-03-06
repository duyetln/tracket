require 'clause'

class OrClause < Clause
  def satisfied?(issue)
    conditions.any? { |c| c.satisfied?(issue) } ||
      clauses.any? { |c| c.satisfied?(issue) }
  end

  def arel_query
    issues = Arel::Table.new(:issues)
    select = issues.project(issues[:id].as('issue_id'))

    union = Arel::Nodes::TableAlias.new(arel_queries.reduce do |a, e|
      Arel::Nodes::Union.new(a, e)
    end, generate_table_alias)

    select.join(union).on(issues[:id].eq(union[:issue_id]))
  end

  def description
    cond_desc = conditions.map(&:description).join(' OR ')
    clse_desc = clauses.map(&:description).map { |desc| "(#{desc})" }.join(' OR ')
    [cond_desc, clse_desc].select(&:present?).join(' OR ')
  end
end

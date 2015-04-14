require 'models/condition'

class NotEqual < Condition
  def satisfy?(issue)
    flip(issue[field] != value)
  end

  def arel_query
    query_table.project(:issue_id).where(
      query_table[:field_id].eq(field.id).and(
        query_table[field.value_column].not_eq(value)
      )
    )
  end
end

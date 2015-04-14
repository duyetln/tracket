require 'models/condition'

class Equal < Condition
  def satisfy?(issue)
    flip(issue[field] == value)
  end

  def arel_query
    query_table.project(:issue_id).where(
      query_table[:field_id].eq(field.id).and(
        query_table[field.value_column].eq(value)
      )
    )
  end
end

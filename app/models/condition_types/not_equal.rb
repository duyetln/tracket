require 'condition'

class NotEqual < Condition
  def satisfied?(issue)
    flip_bool(issue[field] != value)
  end

  def arel_query
    query_table.project(:issue_id).where(
      query_table[:field_id].eq(field.id).and(
        flip_query(query_table[field.value_column].not_eq(value))
      )
    )
  end

  def description
    flip_description("#{field.description} != #{field.value_description(value)}")
  end
end

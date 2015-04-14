require 'models/condition'
require 'models/field_types/string_field'
require 'models/field_types/text_field'
require 'models/field_types/option_field'

class LessThan < Condition
  validates :field_class, exclusion: { in: [StringField, TextField, OptionField], message: "#{self.name} is not supported for %{value}" }

  def satisfy?(issue)
    flip(issue[field] < value)
  end

  def arel_query
    query_table.project(:issue_id).where(
      query_table[:field_id].eq(field.id).and(
        query_table[field.value_column].lt(value)
      )
    )
  end
end

require 'models/condition'
require 'models/field_types/string_field'
require 'models/field_types/text_field'
require 'models/field_types/option_field'

class GreaterThanEqual < Condition
  validates :field_class, exclusion: { in: [StringField, TextField, OptionField], message: "#{self.name} is not supported for %{value}" }

  def satisfy?(issue)
    flip_bool(issue[field] >= value)
  end

  def arel_query
    query_table.project(:issue_id).where(
      query_table[:field_id].eq(field.id).and(
        flip_query(query_table[field.value_column].gteq(value))
      )
    )
  end

  def description
    flip_description("#{field.description} >= #{field.value_description(value)}")
  end
end

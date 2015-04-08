require 'models/condition'
require 'models/field_types/string_field'
require 'models/field_types/text_field'
require 'models/field_types/option_field'

class GreaterThanEqual < Condition
  validates :field_class, exclusion: { in: [StringField, TextField, OptionField], message: "#{self.name} is not supported for %{value}" }

  def satisfy?(issue)
    issue[field] >= value
  end
end

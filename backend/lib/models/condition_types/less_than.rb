require 'models/condition'
require 'models/field_types/string_field'
require 'models/field_types/text_field'
require 'models/field_types/option_field'

class LessThan < Condition
  validates :field_class, exclusion: { in: [StringField, TextField, OptionField], message: '%{value} is not supported' }

  def satisfy?(issue)
    issue[field] < value
  end
end

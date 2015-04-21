require 'models/field'

class StringField < Field
  def self.value_column
    :string_value
  end
  
  def value_description(value)
    "\"#{value}\""
  end
end

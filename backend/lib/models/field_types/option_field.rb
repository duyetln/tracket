require 'models/field'

class OptionField < Field
  has_many :options, inverse_of: :option_field

  def self.value_column
    :option_value
  end
  
  def value_description(value)
    "\"#{options.find(value).name}\""
  end
end

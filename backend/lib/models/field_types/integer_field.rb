require 'models/field'

class IntegerField < Field
  def self.value_column
    :integer_value
  end
  
  def value_description(value)
    value.to_s
  end
end

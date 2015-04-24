require 'models/field'

class DateTimeField < Field
  def self.value_column
    :date_time_value
  end
  
  def value_description(value)
    "\"#{value.to_s(:rfc822)}\""
  end
end

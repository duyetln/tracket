require 'models/field'

class DateTimeField < Field
  def self.value_column
    :date_time_value
  end
end

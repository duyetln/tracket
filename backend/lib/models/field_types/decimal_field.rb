require 'models/field'

class DecimalField < Field
  def self.value_column
    :decimal_value
  end
end

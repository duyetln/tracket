require 'field'

class DecimalField < Field
  def self.value_column
    :decimal_value
  end

  def value_description(value)
    super
  end
end

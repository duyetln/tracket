require 'field'

class IntegerField < Field
  def self.value_column
    :integer_value
  end

  def value_description(value)
    super
  end
end

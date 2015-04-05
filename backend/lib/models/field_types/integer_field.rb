require 'models/field'

class IntegerField < Field
  def self.value_column
    :integer_value
  end
end

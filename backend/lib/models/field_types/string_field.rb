require 'models/field'

class StringField < Field
  def self.value_column
    :string_value
  end
end

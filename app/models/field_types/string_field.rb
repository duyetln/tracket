require 'field'

class StringField < Field
  def self.value_column
    :string_value
  end

  def value_description(value)
    super(value) { |v| "\"#{v}\"" }
  end
end

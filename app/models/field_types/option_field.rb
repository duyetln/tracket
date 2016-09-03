require 'field'

class OptionField < Field
  has_many :options, inverse_of: :option_field

  def self.value_column
    :option_value
  end

  def value_description(value)
    super(value) { |v| "\"#{options.find(v).name}\"" }
  end
end

require 'models/field'

class OptionField < Field
  has_many :options, inverse_of: :option_field

  def self.value_column
    :option_value
  end
end

require 'models/field'

class OptionField < Field
  has_many :options, inverse_of: :option_field

  def self.value_column
    :option_value
  end

  # overridden
  def self.lt?(issue, value)
    not_supported!(LessThan)
  end

  def self.gt?(issue, value)
    not_supported!(GreaterThan)
  end

  def self.lte?(issue, value)
    not_supported!(LessThanEqual)
  end

  def self.gte?(issue, value)
    not_supported!(GreaterThanEqual)
  end
end

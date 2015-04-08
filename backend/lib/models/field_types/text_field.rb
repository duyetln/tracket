require 'models/field'

class TextField < Field
  def self.value_column
    :text_value
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

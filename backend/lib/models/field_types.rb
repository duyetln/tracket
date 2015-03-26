require 'models/field'

class StringField < Field
  def self.value_column
    :string_value
  end
end

class TextField < Field
  def self.value_column
    :text_value
  end
end

class IntegerField < Field
  def self.value_column
    :integer_value
  end
end

class DecimalField < Field
  def self.value_column
    :decimal_value
  end
end

class DatetimeField < Field
  def self.value_column
    :datetime_value
  end
end

class OptionField < Field
  has_many :options, inverse_of: :option_field

  def self.value_column
    :option_value
  end
end

require 'models/field'

class TextField < Field
  def self.value_column
    :text_value
  end
end

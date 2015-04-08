require 'models/condition'

class NotEqual < Condition
  def satisfy?(issue)
    field.neq?(issue, value)
  end
end

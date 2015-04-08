require 'models/condition'

class GreaterThanEqual < Condition
  def satisfy?(issue)
    field.gte?(issue, value)
  end
end

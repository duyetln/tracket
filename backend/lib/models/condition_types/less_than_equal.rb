require 'models/condition'

class LessThanEqual < Condition
  def satisfy?(issue)
    field.lte?(issue, value)
  end
end

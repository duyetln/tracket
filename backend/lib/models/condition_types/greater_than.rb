require 'models/condition'

class GreaterThan < Condition
  def satisfy?(issue)
    field.gt?(issue, value)
  end
end

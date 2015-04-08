require 'models/condition'

class LessThan < Condition
  def satisfy?(issue)
    field.lt?(issue, value)
  end
end

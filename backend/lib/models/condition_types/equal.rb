require 'models/condition'

class Equal < Condition
  def satisfy?(issue)
    field.eq?(issue, value)
  end
end

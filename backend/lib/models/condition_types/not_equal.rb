require 'models/condition'

class NotEqual < Condition
  def satisfy?(issue)
    flip(issue[field] != value)
  end
end

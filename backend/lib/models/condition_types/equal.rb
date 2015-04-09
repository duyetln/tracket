require 'models/condition'

class Equal < Condition
  def satisfy?(issue)
    flip(issue[field] == value)
  end
end

require 'models/condition'

class Equal < Condition
  def satisfy?(issue)
    issue[field] == value
  end
end

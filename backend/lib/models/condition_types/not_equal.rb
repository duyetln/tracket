require 'models/condition'

class NotEqual < Condition
  def satisfy?(issue)
    issue[field] != value
  end
end

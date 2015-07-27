require 'models/rule'

class AssignmentRule < ActiveRecord::Base
  def value
    send(field.value_column)
  end

  def value=(value)
    send("#{field.value_column}=", value)
  end
end

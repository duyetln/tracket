require 'models/rule'

class AssignmentRule < Rule
  attr_readonly :field_id

  belongs_to :field

  validates :field, presence: true

  def value
    send(field.value_column)
  end

  def value=(value)
    send("#{field.value_column}=", value)
  end

  def description
    prerequisite_description + "set #{field.description} to #{field.value_description(value)}"
  end
end

class Condition < ActiveRecord::Base
  attr_readonly :clause_id
  attr_readonly :field_id
  attr_readonly :inversed

  belongs_to :clause, inverse_of: :conditions
  belongs_to :field

  with_options presence: true do |c|
    c.validates :clause
    c.validates :field
  end

  def value
    send(self.field.value_column)
  end

  def value=(value)
    send("#{self.field.value_column}=", value)
  end
end

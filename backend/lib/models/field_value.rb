class FieldValue < ActiveRecord::Base
  attr_readonly :issue_id
  attr_readonly :field_id

  belongs_to :issue, inverse_of: :field_values
  belongs_to :field

  with_options presence: true do |f|
    f.validates :issue
    f.validates :field
  end

  def value
    send(self.field.value_column)
  end

  def value=(value)
    send("#{self.field.value_column}=", value)
  end
end

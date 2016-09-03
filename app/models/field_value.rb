require 'application_record'

class FieldValue < ApplicationRecord
  attr_readonly :issue_id
  attr_readonly :field_id

  belongs_to :issue, inverse_of: :field_values, touch: true
  belongs_to :field

  with_options presence: true do |f|
    f.validates :issue
    f.validates :field
  end

  def value
    send(field.value_column)
  end

  def value=(value)
    send("#{field.value_column}=", value)
  end

  def modified?
    !!send("#{field.value_column}_changed?")
  end
end

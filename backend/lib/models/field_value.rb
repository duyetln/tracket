class FieldValue < ActiveRecord::Base
  attr_readonly :issue_id
  attr_readonly :field_id

  belongs_to :issue, inverse_of: :field_values
  belongs_to :field, inverse_of: :field_values

  with_options presence: true do |f|
    f.validates :issue
    f.validates :field
  end
end

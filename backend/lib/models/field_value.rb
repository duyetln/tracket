class FieldValue < ActiveRecord::Base
  belongs_to :issue
  belongs_to :field
end

class Option < ActiveRecord::Base
  attr_readonly :field_id

  belongs_to :option_field, inverse_of: :options

  validates :option_field, presence: true
end

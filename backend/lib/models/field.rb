class Field < ActiveRecord::Base
  attr_readonly :project_id

  belongs_to :project, inverse_of: :fields

  with_options presence: true do |f|
    f.validates :name
    f.validates :project
  end

  delegate :value_column, to: :class
end

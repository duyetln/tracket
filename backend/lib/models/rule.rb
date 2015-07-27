class Rule < ActiveRecord::Base
  attr_readonly :project_id
  attr_readonly :field_id
  attr_readonly :prerequisite_type
  attr_readonly :prerequisite_id

  belongs_to :project
  belongs_to :field
  belongs_to :prerequisite, polymorphic: true

  with_options presence: true do |r|
    r.validates :project
    r.validates :field
  end
  validates :prerequisite_type, inclusion: { in: %w(Clause Condition) }

  def qualified?(issue)
    prerequisite.blank? || issue.satisfied?(prerequisite)
  end
end

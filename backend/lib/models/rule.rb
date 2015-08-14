class Rule < ActiveRecord::Base
  attr_readonly :project_id
  attr_readonly :prerequisite_type
  attr_readonly :prerequisite_id

  belongs_to :project
  belongs_to :prerequisite, polymorphic: true

  validates :project, presence: true
  validates :prerequisite_type, inclusion: { in: %w(Clause Condition) }

  def qualified?(issue)
    prerequisite.blank? || issue.satisfied?(prerequisite)
  end

  protected

  def prerequisite_description
    prerequisite.present? ? "When (#{prerequisite.description}), " : "Always "
  end
end

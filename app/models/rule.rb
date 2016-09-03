require 'application_record'

class Rule < ApplicationRecord
  attr_readonly :project_id
  attr_readonly :assertion_type
  attr_readonly :assertion_id
  attr_readonly :prerequisite_type
  attr_readonly :prerequisite_id

  belongs_to :project, inverse_of: :rules
  belongs_to :assertion, polymorphic: true
  belongs_to :prerequisite, polymorphic: true

  validates :project, presence: true
  validates :assertion, presence: true
  validates :assertion_type, inclusion: { in: %w(Clause Condition) }
  validates :prerequisite_type, inclusion: { in: %w(Clause Condition) }, if: ->(r) { r.prerequisite.present? }

  def qualified?(issue)
    prerequisite.blank? || issue.satisfied?(prerequisite)
  end

  def description
    (prerequisite.present? ? "When (#{prerequisite.description}), " : 'Always ') + "assert (#{assertion.description})"
  end
end

require 'models/rule'

class AssertionRule < Rule
  attr_readonly :assertion_type
  attr_readonly :assertion_id

  belongs_to :assertion, polymorphic: true

  validates :assertion, presence: true
  validates :assertion_type, inclusion: { in: %w(Clause Condition) }
end

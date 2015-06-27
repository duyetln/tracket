require 'models/clause'
require 'models/condition'
require 'models/issue'

class Query < ActiveRecord::Base
  attr_readonly :project_id
  attr_readonly :identifier
  attr_readonly :constraint_type
  attr_readonly :constraint_id
  
  belongs_to :project
  belongs_to :constraint, polymorphic: true
  
  with_options presence: true do |q|
    q.validates :project
    q.validates :constraint
  end
  validates :identifier, uniqueness: true
  validates :constraint_type, inclusion: { in: %w(Clause Condition) }
  
  before_create :set_identifier
  
  def issues
    issue = Issue.arel_table
    Issue.includes(:field_values).where(issue[:project_id].eq(project_id).and(issue[:id].in(constraint.arel_query)))
  end
  
  def description
    "Query: #{constraint.description}"  
  end
  
  protected
  
  def set_identifier
    loop do
      self.identifier = SecureRandom.urlsafe_base64(8)
      break unless self.class.exists?(identifier: self.identifier)
    end
  end
end

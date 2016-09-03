require 'application_record'

class Query < ApplicationRecord
  attr_readonly :project_id
  attr_readonly :identifier
  attr_readonly :criterion_type
  attr_readonly :criterion_id

  belongs_to :project
  belongs_to :criterion, polymorphic: true

  with_options presence: true do |q|
    q.validates :project
    q.validates :criterion
  end
  validates :identifier, uniqueness: true
  validates :criterion_type, inclusion: { in: %w(Clause Condition) }

  before_create :set_identifier

  def issues(type, offset: 0, limit: 0)
    type ||= :all
    issue = Issue.arel_table
    where = issue[:project_id].eq(project_id).and(issue[:id].in(criterion.arel_query))

    case type
    when :count
      query = issue.project(Arel.star.count).where(where)
      Issue.count_by_sql(query.to_sql)
    when :all
      query = issue.project(Arel.star).where(where).order(issue[:created_at].desc)
      query = query.skip(offset) if offset.positive?
      query = query.take(limit) if limit.positive?
      Issue.find_by_sql(query.to_sql)
    end
  end

  def description
    "Query: #{criterion.description}"
  end

  protected

  def set_identifier
    loop do
      self.identifier = SecureRandom.urlsafe_base64(8)
      break unless self.class.exists?(identifier: identifier)
    end
  end
end

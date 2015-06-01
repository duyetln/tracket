class Clause < ActiveRecord::Base
  validate :ensure_present_clauses_or_conditions

  protected

  def ensure_present_clauses_or_conditions
    unless (clauses.size + conditions.size) > 1
      errors.add(:clause, 'must have at least two literals (clause, condition)')
    end
  end

  def generate_table_alias
    "#{self.class.name.underscore}_#{SecureRandom.hex(4)}"
  end

  def arel_queries
    @arel_queries ||= (conditions + clauses).map(&:arel_query)
  end
end

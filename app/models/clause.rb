require 'application_record'

class Clause < ApplicationRecord
  has_many :junctions, foreign_key: :parent_clause_id, inverse_of: :parent_clause
  has_many :clauses, through: :junctions
  has_many :conditions, through: :junctions

  validate :ensure_one_nesting_layer
  validate :ensure_present_clauses_or_conditions

  protected

  def ensure_one_nesting_layer
    if clauses.map(&:clauses).map(&:size).any?(&:positive?)
      errors.add(:clause, 'must not have more than one nesting layer')
    end
  end

  def ensure_present_clauses_or_conditions
    if (clauses.size + conditions.size) <= 1
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

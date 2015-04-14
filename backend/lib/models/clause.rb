class Clause < ActiveRecord::Base
  attr_readonly :parent_id
  attr_readonly :inversed

  belongs_to :parent, class_name: 'Clause', inverse_of: :clauses
  has_many :clauses, foreign_key: :parent_id, inverse_of: :parent
  has_many :conditions, inverse_of: :clause

  validate :ensure_no_circular_reference
  validate :ensure_present_clauses_or_conditions

  protected

  def ensure_no_circular_reference
    parent = self.parent
    while parent.present?
      if self == parent
        errors.add(:clause, 'must not cicularly reference itself')
        break
      end
      parent = parent.parent
    end
  end

  def ensure_present_clauses_or_conditions
    unless (clauses.size + conditions.size) > 1
      errors.add(:clause, 'must have at least two literals (clause, condition)')
    end
  end

  def flip(bool)
    inversed? ? !bool : bool
  end

  def generate_table_alias
    "#{self.class.name.underscore}_#{SecureRandom.hex(4)}"
  end

  def arel_queries
    @arel_queries ||= (conditions + clauses).map(&:arel_query)
  end
end

class Junction < ActiveRecord::Base
  attr_readonly :clause_id
  attr_readonly :condition_id

  belongs_to :parent_clause, class_name: 'Clause', inverse_of: :junctions
  belongs_to :clause
  belongs_to :condition

  validates :clause_id, uniqueness: { scope: :parent_clause_id }
  validates :condition_id, uniqueness: { scope: :parent_clause_id }

  validate :ensure_no_circular_reference

  protected

  def ensure_no_circular_reference
    if parent_clause == clause
      errors.add(:junction, 'must not have circular reference')
    end
  end
end

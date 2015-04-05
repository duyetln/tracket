class Clause < ActiveRecord::Base
  attr_readonly :parent_id

  belongs_to :parent, class_name: 'Clause', inverse_of: :clauses
  has_many :clauses, foreign_key: :parent_id, inverse_of: :parent

  validate :ensure_no_circular_reference

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
end

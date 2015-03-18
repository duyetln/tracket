class Option < ActiveRecord::Base
  attr_readonly :field_id

  belongs_to :field, inverse_of: :options

  validates :field, presence: true
  validate :ensure_option_field

  protected

  def ensure_option_field
    unless field.class.name == 'OptionField'
      errors.add(:field, 'must be OptionField')
    end
  end
end

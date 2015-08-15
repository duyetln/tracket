require 'models/field'
require 'models/field_value'

class Issue < ActiveRecord::Base
  attr_readonly :project_id
  attr_readonly :number

  belongs_to :project, inverse_of: :issues
  has_many :field_values, inverse_of: :issue, autosave: true

  with_options presence: true do |i|
    i.validates :name
    i.validates :field_values
  end
  validates :number, uniqueness: { scope: :project_id }
  validate :ensure_single_field_value
  validate :ensure_satisfied_rules

  after_initialize :initialize_field_values
  before_create :set_number

  delegate :fields, to: :project

  def [](field)
    return super unless field.is_a?(Field)
    field_value(field).value
  end

  def []=(field, value)
    return super unless field.is_a?(Field)
    field_value(field).value = value
  end

  def satisfied?(clause_or_condition)
    clause_or_condition.satisfied?(self)
  end

  def qualified?(rule)
    rule.qualified?(self)
  end

  def modified?(field = nil)
    field ? field_value(field).modified? : field_values.any?(&:modified?)
  end

  protected

  def ensure_single_field_value
    unless fields.all? { |f| field_values.select { |fv| fv.field == f }.size == 1 }
      errors.add(:issue, 'must have exactly one field value for each field')
    end
  end

  def ensure_satisfied_rules
    project.rules.each do |rule|
      if qualified?(rule) && !satisfied?(rule.assertion)
        errors.add(:issue, rule.description)
      end
    end
  end

  def initialize_field_values
    fields.reject { |f| field_value(f) }.each do |field|
      field_values << FieldValue.new(field: field)
    end
  end

  def set_number
    self.number = (self.class.where(project_id: project_id).maximum(:number) || 0) + 1
  end

  def field_value(field)
    field_values.find { |fv| fv.field == fields.find(field.id) }
  end
end

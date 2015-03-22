require 'models/field'

class Issue < ActiveRecord::Base
  attr_readonly :project_id
  attr_readonly :number

  belongs_to :project, inverse_of: :issues
  has_many :field_values, inverse_of: :issue

  with_options presence: true do |i|
    i.validates :number
    i.validates :name
    i.validates :project
    i.validates :field_values
  end
  validate :ensure_field_values_presence

  delegate :fields, to: :project

  def [](field)
    unless field.is_a?(Field)
      return super
    end
    field_value(field).first!.value
  end

  def []=(field, value)
    unless field.is_a?(Field)
      return super
    end
    field_value = field_value(field).first_or_initialize
    field_values << field_value
    field_value.value = value
  end

  protected

  def ensure_field_values_presence
    fields.each do |field|
      unless field_values.detect { |fv| fv.field == field }
        errors.add(:field_values, "is missing value for '#{field.name}'")
      end
    end
  end

  def field_value(field)
    field_values.where(field_id: field(field).id)
  end

  def field(id)
    fields.where(id: (id.is_a?(Field) ? id.id : id)).first!
  end
end

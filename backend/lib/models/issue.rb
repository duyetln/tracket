require 'models/field'
require 'models/field_value'

class Issue < ActiveRecord::Base
  attr_readonly :project_id
  attr_readonly :number

  belongs_to :project, inverse_of: :issues
  has_many :field_values, inverse_of: :issue

  with_options presence: true do |i|
    i.validates :number, uniqueness: { scope: :project_id }
    i.validates :name
    i.validates :project
    i.validates :field_values
  end

  after_initialize :initialize_values

  delegate :fields, to: :project

  def [](field)
    return super unless field.is_a?(Field)
    field_value(field).value
  end

  def []=(field, value)
    return super unless field.is_a?(Field)
    field_value(field).value = value
  end

  protected

  def initialize_values
    self.number = self.class.where(project_id: project_id).maximum(:number) + 1 if new_record?
    fields.each do |field|
      field_values << FieldValue.new(field: field) unless field_value(field)
    end
  end

  def field_value(field)
    field_values.find { |fv| fv.field == fields.find(field.id) }
  end
end

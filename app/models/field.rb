require 'application_record'

class Field < ApplicationRecord
  attr_readonly :project_id

  belongs_to :project, inverse_of: :fields

  with_options presence: true do |f|
    f.validates :name
    f.validates :project
  end

  delegate :value_column, to: :class

  def description
    "\"#{name}\""
  end

  protected

  def value_description(value)
    value.nil? ? 'NULL' : (block_given? ? (yield value) : value.to_s)
  end
end

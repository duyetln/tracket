class Condition < ActiveRecord::Base
  attr_readonly :field_id
  attr_readonly :inversed

  belongs_to :field

  validates :field, presence: true

  def value
    send(field.value_column)
  end

  def value=(value)
    send("#{field.value_column}=", value)
  end

  protected

  def field_class
    field.class
  end

  def flip_bool(bool)
    inversed? ? !bool : bool
  end

  def flip_query(query)
    inversed? ? query.not : query
  end

  def flip_description(description)
    inversed? ? "NOT (#{description})" : description
  end

  def query_table
    @query_table ||= Arel::Table.new(:field_values)
  end
end

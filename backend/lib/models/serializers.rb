class BaseSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :updated_at, :created_at
end

class DynamicSerializer < SimpleDelegator
  def initialize(resource, options = {})
    __setobj__("#{resource.class.name.demodulize}Serializer".constantize.new(resource, options))
  end
end

# options
class OptionSerializer < BaseSerializer
  attributes :name
end

# fields
class FieldSerializer < BaseSerializer
  attributes :project_id, :name, :type
end

class DateTimeFieldSerializer < FieldSerializer
end

class DecimalFieldSerializer < FieldSerializer
end

class IntegerFieldSerializer < FieldSerializer
end

class StringFieldSerializer < FieldSerializer
end

class TextFieldSerializer < FieldSerializer
end

class OptionFieldSerializer < FieldSerializer
  has_many :options, serializer: 'OptionSerializer'
end

# rule
class RuleSerializer < BaseSerializer
  attributes :project_id, :description
end

# project
class ProjectSerializer < BaseSerializer
  attributes :name, :description
  has_many :fields, serializer: 'DynamicSerializer'
  has_many :rules, serializer: 'RuleSerializer'
end

# field values
class FieldValueSerializer < BaseSerializer
  attributes :issue_id, :field_id, :value
end

# issues
class IssueSerializer < BaseSerializer
  attributes :project_id, :number, :name, :description
  has_many :field_values, serializer: 'FieldValueSerializer'
end

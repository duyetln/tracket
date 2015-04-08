require 'models/condition_types/equal'
require 'models/condition_types/not_equal'
require 'models/condition_types/less_than'
require 'models/condition_types/greater_than'
require 'models/condition_types/less_than_equal'
require 'models/condition_types/greater_than_equal'

class Field < ActiveRecord::Base
  attr_readonly :project_id

  belongs_to :project, inverse_of: :fields

  with_options presence: true do |f|
    f.validates :name
    f.validates :project
  end

  delegate :value_column, to: :class
  delegate :eql?, :neql?, :lt?, :gt?, :lte?, :gte?, to: :class

  class << self
    def eq?(issue, value)
      issue[self] == value
    end

    def neq?(issue, value)
      !neql?(issue, value)
    end

    def lt?(issue, value)
      issue[self] < value
    end

    def gt?(issue, value)
      issue[self] > value
    end

    def lte?(issue, value)
      !gt?(issue, value)
    end

    def gte?(issue, value)
      !lt?(issue, value)
    end

    protected

    def not_supported!(condition_type)
      raise "#{self.class} does not support #{condition_type}"
    end
  end
end

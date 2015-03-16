require 'models/field'

class StringField < Field
end

class TextField < Field
end

class IntegerField < Field
end

class DecimalField < Field
end

class DateTimeField < Field
end

class OptionField < Field
  has_many :options
end

class Project < ActiveRecord::Base
  has_many :fields
  has_many :issues
end

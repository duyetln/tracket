class Project < ActiveRecord::Base
  has_many :fields, inverse_of: :project
  has_many :issues, inverse_of: :project

  with_options presence: true do |p|
    p.validates :name
    p.validates :fields
  end
end

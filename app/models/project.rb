require 'application_record'

class Project < ApplicationRecord
  has_many :fields, inverse_of: :project
  has_many :issues, inverse_of: :project
  has_many :rules, inverse_of: :project

  with_options presence: true do |p|
    p.validates :name
    p.validates :fields
  end
end

require 'spec_setup'

RSpec.configure do |config|
  config.include SpecHelpers::Models

  config.before :each do |example|
    DatabaseCleaner.start unless example.metadata[:no_db_clean]
  end

  config.after :each do |example|
    DatabaseCleaner.clean unless example.metadata[:no_db_clean]
  end
end

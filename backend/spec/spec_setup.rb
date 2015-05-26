ENV['RACK_ENV'] = 'test'

require 'simplecov'

SimpleCov.start do
  add_filter '/db/'
  add_filter '/spec/'
  add_filter '/config/'

  add_group 'models', 'lib/models'
  add_group 'services', 'lib/services'
end

require './boot'
Dir['spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.order = 'random'

  config.before :suite do
    FactoryGirl.find_definitions

    begin
      factories = FactoryGirl.factories.reject do |factory|
        factory.name == :condition
      end
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with :truncation
      FactoryGirl.lint factories
    ensure
      DatabaseCleaner.clean_with :truncation
    end
  end
end

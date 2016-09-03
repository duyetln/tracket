ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

SimpleCov.start do
  add_filter '/db/'
  add_filter '/spec/'
  add_filter '/config/'

  add_group 'models', 'app/models'
  add_group 'controllers', 'app/controllers'
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  config.disable_monkey_patching!
  config.filter_rails_from_backtrace!
  config.infer_spec_type_from_file_location!
  config.profile_examples = 10
  config.order = :random
  config.color = true
  config.tty = true

  config.before :suite do
    FactoryGirl.find_definitions

    begin
      factories = FactoryGirl.factories.reject do |factory|
        factory.name == :condition ||
          factory.name == :clause
      end
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with :truncation
      FactoryGirl.lint factories
    ensure
      DatabaseCleaner.clean_with :truncation
    end
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

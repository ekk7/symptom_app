# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

Date::DATE_FORMATS[:default]="%d/%m/%Y"

Rails.application.configure do
  config.action_controller.session_store = :active_record_store
  end
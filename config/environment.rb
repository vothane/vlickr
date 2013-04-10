# Load the rails application.
require File.expand_path('../application', __FILE__)

# Initialize the rails application.
Vlickr::Application.initialize!

# Load custom config file for current environment
raw_config = File.read(RAILS_ROOT + "/config/config.yml")
APP_CONFIG = YAML.load(raw_config)[RAILS_ENV]
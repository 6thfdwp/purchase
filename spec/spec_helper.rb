$LOAD_PATH << '..'
require 'item'
require 'taxrater'
require 'purchase'

require 'yaml'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :should
  end
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

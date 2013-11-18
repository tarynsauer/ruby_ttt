require_relative '../ai'
require_relative '../board'
require_relative '../game'
require_relative '../line'
require_relative '../player'

RSpec.configure do |config|
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation
end
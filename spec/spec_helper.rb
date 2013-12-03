require 'coveralls'
Coveralls.wear!

require_relative '../lib/ai'
require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/ui'
require_relative '../lib/game_setup'

RSpec.configure do |config|
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation
end
File.join(File.expand_path(File.dirname(__FILE__)), "..", "lib")
require 'player_factory'
require 'game'

setup = CLIGameSetup.new
settings = setup.get_settings
Game.new(settings)
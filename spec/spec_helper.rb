require 'coveralls'
Coveralls.wear!

require_relative '../lib/ai'
require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/ui'

class TestGame < Game
  attr_accessor :player_one, :player_two, :board, :game_over, :difficulty_level, :ai, :ui
    def initialize(board)
      @board      = board
      @ui         = UI.new(@board)
      @player_one = Player.new('X', 'human', @board)
      @player_two = Player.new('O', 'human', @board)
      @player_one.opponent = @player_two
      @player_two.opponent = @player_one
      @game_over  = false
      @ai         = AI.new
      @difficulty_level = 'hard'
  end
end

RSpec.configure do |config|
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation
end
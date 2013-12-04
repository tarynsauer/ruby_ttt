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

class MockBoard
  attr_accessor :num_of_rows, :all_cells, :winning_rows
  def initialize
    @num_of_rows  = 3
    @all_cells    = {},
    @winning_rows = [[],[],[]]
  end
end

class MockPlayer
  attr_accessor :marker, :board, :player_type, :opponent
  def initialize(marker, board)
    @marker = marker
    @board  = board
    @player_type = 'human'
    @opponent = nil
  end
end

class MockKernel
    @@input = nil
    @@lines = []
    @@output = nil
    @@gets_string = ''
    def self.print(string)
      @@input = string
      @@lines.push(@@input)
    end

    def self.last_print_call
      @@input
    end

    def self.last_lines(num)
      @@lines[-num..-1].join('')
    end

    def self.set_gets(string)
      @@gets_string = string
    end

    def self.gets
      @@gets_string
    end
  end
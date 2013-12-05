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
  attr_accessor :marker, :board, :player_type, :turn, :opponent
  def initialize(marker, board)
    @marker = marker
    @board  = board
    @turn = 0
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

  class MockUI < UI
    def initialize(board)
      super
      @request_player_type = 0
      @request_difficulty_level = 0
      @type_assigned_message = 0
      @level_assigned_message = 0
    end

    def request_player_type(marker)
      @request_player_type += 1
    end

    def request_player_type_called
      @request_player_type
    end

    def request_difficulty_level
      @request_difficulty_level += 1
    end

    def request_difficulty_level_called
      @request_difficulty_level
    end

    def type_assigned_message(type, marker)
      @type_assigned_message += 1
    end

    def type_assigned_message_called
      @type_assigned_message
    end

    def level_assigned_message(level)
      @level_assigned_message += 1
    end

    def level_assigned_message_called
      @level_assigned_message
    end
  end
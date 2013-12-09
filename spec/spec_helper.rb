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
  attr_accessor :num_of_rows, :all_cells, :winning_lines
  def initialize
    @num_of_rows  = 3
    @all_cells    = {"1A"=>nil, "2A"=>nil, "3A"=>nil,
                     "1B"=>nil, "2B"=> nil, "3B"=>nil,
                     "1C"=>nil, "2C"=>nil, "3C"=>nil},
    @winning_lines = [[],[],[]]
  end

  def random_cell
    'A1'
  end

  def valid_cell?(cell)
    cell == '3C'
  end

  def winner?(marker)
    marker == 'X'
  end

  def moves_remaining?
    false
  end

  def game_over?
  end

  def all_rows
    [['1A', '2A', '3A'],
     ['1B', '2B', '3B'],
     ['1C', '2C', '3C']]
  end
end

class MockAI
  def self.computer_move(board, player)
    'A2'
  end
end

class MockPlayer
  attr_accessor :marker, :player_type, :turn, :opponent
  def initialize(marker)
    @marker = marker
    @turn = 0
    @player_type = 'human'
    @opponent = nil
  end

  def next_player_turn
  end

  def current_player?
    self.turn == 1
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
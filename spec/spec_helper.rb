require 'simplecov'
SimpleCov.start

require 'game_setup'
require 'player_factory'
require 'ai'
require 'board'
require 'game'
require 'player'
require 'ui'

RSpec.configure do |config|
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation
end

class MockBoard
  attr_accessor :num_of_rows, :all_cells, :winning_lines
  def initialize
    @num_of_rows = 3
    @all_cells = { "1A"=>nil, "2A"=>nil, "3A"=>nil,
                   "1B"=>nil, "2B"=>nil, "3B"=>nil,
                   "1C"=>nil, "2C"=>nil, "3C"=>nil }
    @winning_lines = [['1A', '2A', '3A'],['1B', '2B', '3B'],['1C', '2C', '3C'],
                      ['1A', '1B', '1C'],['2A', '2B', '2C'],['3A', '3B', '3C'],
                      ['1A','2B','3C'],['1C','2B','3A']]
    @game_over = false
  end

  def random_cell
    'A1'
  end

  def winner?
  end

  def valid_cell?(cell)
    cell == '3C'
  end

  def moves_remaining?
    false
  end

  def available_cell?(cell)
    @game_over = true
  end

  def all_rows
    [['1A', '2A', '3A'],
     ['1B', '2B', '3B'],
     ['1C', '2C', '3C']]
  end
end

class MockUI
  attr_accessor :io, :board
  def initialize
    @io = Kernel
    @board = MockBoard.new
  end

  def display_board; end

  def request_human_move
    '1A'
  end

  def winning_game_message(player)
  end

  def level_assigned_message(level)
    'level assigned'
  end
end

class MockPlayer
  attr_accessor :marker, :opponent
  def initialize(marker)
    @marker = marker
    @opponent = nil
  end
end

class MockKernel
  @@input = nil
  @@lines = []
  @@output = nil
  @@gets_string = ''
  @@gets_sequence_array = []

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

  def self.set_gets_sequence(array)
    @@gets_sequence_array = array
  end

  def self.gets
    (@@gets_sequence_array.length > 0) ? @@gets_sequence_array.shift : @@gets_string
  end

  def self.exit
    'exited'
  end
end
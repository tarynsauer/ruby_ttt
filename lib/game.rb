require './lib/ai'
require './lib/board'
require './lib/game'
require './lib/player'

class Game

  attr_accessor :player_one, :player_two, :board, :game_over, :ai
  def initialize(player_one_type, player_two_type, board)
    @board      = board
    @player_one = Player.new('X', player_one_type, @board)
    @player_two = Player.new('O', player_two_type, @board)
    @player_one.opponent = @player_two
    @player_two.opponent = @player_one
    @game_over  = false
    @ai         = AI.new
    who_goes_first
  end

  def who_goes_first
    if rand(0..1) == 1
      player_one.turn = 1
    else
      player_two.turn = 1
    end
    board.first_move_message(current_player)
  end

  def self.get_player_type(marker)
    print "For player " + "'#{marker}'," + " enter 'human' or 'computer.'\n"
    type = gets.chomp.downcase
    if (type == 'human') || (type == 'computer')
      print "Player " + "'#{marker}' " + "is #{type}.\n"
    else
      self.invalid_type(type, marker)
    end
    type
  end

  def self.invalid_type(type, marker)
    print "#{type} is not a valid option."
    self.get_player_type(marker)
  end

  def game_status_update
    winner_check
    tie_game_check
    board.next_move_message(current_player)
    board.display_board
  end

  def winner_check
    if board.winning_move?(current_player.marker)
      board.winning_game_message(current_player)
      exit_game
    end
  end

  def tie_game_check
    if !board.moves_remaining?
      board.tie_game_message
      exit_game
    end
  end

  def current_player
    player_one.turn == 1 ? player_one : player_two
  end

  def standardize(input)
    input.split('').sort.join('').upcase
  end

  def exit_game
    board.display_board
    game_over = true
    exit
  end

  def check_move(cell)
    if board.available_cell?(cell)
      board.add_marker(cell, current_player.marker)
      current_player.next_player_turn
    elsif board.taken_cell_message(cell)
      board.valid_cell?(cell)
    else
      board.bad_cell_message(cell)
    end
  end

  def get_next_move
    if current_player.player_type == "human"
      move = standardize(gets.chomp)
      check_move(move)
    else
      move = ai.computer_move(board, current_player)
      board.add_marker(move, current_player.marker)
      current_player.next_player_turn
    end
  end

  def play!
    until game_over
      game_status_update
      get_next_move
    end
  end

end

player_1 = Game.get_player_type('X')
player_2 = Game.get_player_type('O')
Game.new(player_1, player_2, Board.new).play!
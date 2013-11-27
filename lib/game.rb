require './lib/ai'
require './lib/board'
require './lib/game'
require './lib/player'
require './lib/ui'

class Game
  attr_accessor :player_one, :player_two, :board, :game_over, :ai, :ui
  def initialize(player_one_type, player_two_type, board)
    @board      = board
    @player_one = Player.new('X', player_one_type, @board)
    @player_two = Player.new('O', player_two_type, @board)
    @player_one.opponent = @player_two
    @player_two.opponent = @player_one
    @game_over  = false
    @ai         = AI.new
    @ui         = UI.new(@board)
  end

  def who_goes_first
    if rand(0..1) == 1
      player_one.turn = 1
    else
      player_two.turn = 1
    end
    ui.first_move_message(current_player)
  end

  def self.get_player_type(marker)
    print "For player " + "'#{marker}'," + " enter 'human' or 'computer.'\n"
    type = gets.chomp.downcase
    self.validate_type(type, marker)
  end

  def self.validate_type(type, marker)
    if (type == 'human') || (type == 'computer')
      print "Player " + "'#{marker}' " + "is #{type}.\n"
      type
    else
      self.invalid_type(type, marker)
    end
  end

  def self.invalid_type(type, marker)
    print "#{type} is not a valid option."
    self.get_player_type(marker)
  end

  def game_status_check
    winner_check
    tie_game_check
  end

  def winner_check
    if board.winning_move?(current_player.marker)
      ui.winning_game_message(current_player)
      exit_game
    end
  end

  def tie_game_check
    if !board.moves_remaining?
      ui.tie_game_message
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
    ui.display_board
    game_over = true
    exit
  end

  def check_move(cell)
    if board.available_cell?(cell)
      advance_game(cell, current_player)
    elsif board.valid_cell?(cell)
      ui.taken_cell_message(cell)
    else
      ui.bad_cell_message(cell)
    end
  end

  def advance_game(cell, player)
    board.add_marker(cell, player.marker)
    game_status_check
    player.next_player_turn
    ui.next_move_message(current_player)
  end

  def get_next_move
    current_player.player_type == "human" ? standardize(gets.chomp) : ai.computer_move(board, current_player)
  end

  def play!
    who_goes_first
    until game_over
      ui.display_board
      move = get_next_move
      check_move(move)
    end
  end

end

player_1 = Game.get_player_type('X')
player_2 = Game.get_player_type('O')
Game.new(player_1, player_2, Board.new(3)).play!
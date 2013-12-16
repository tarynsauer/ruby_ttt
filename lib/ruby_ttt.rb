require 'ai'
require 'board'
require 'player'
require 'ui'
require 'game_setup'
class Game
  attr_accessor :board, :ui, :player_one, :player_two, :ai, :difficulty_level
  def initialize(board, ui, player_one, player_two, difficulty_level)
    @board      = board
    @ui         = ui
    @player_one = player_one
    @player_two = player_two
    @ai         = AI.new
    @difficulty_level = difficulty_level
  end

  def verify_move(cell)
    if board.available_cell?(cell)
      board.add_marker(current_player.marker, cell)
      true
    else
      invalid_move(cell)
    end
  end

  def get_computer_move
    difficulty_level == HARD_LEVEL ? ai.computer_move(board, current_player) : board.random_cell
  end

  def computer_move?
    current_player.player_type == COMPUTER_PLAYER
  end

  def advance_game
    game_status_check
    current_player.next_player_turn
    ui.next_move_message(current_player) unless board.game_over?
  end

  def game_status_check
    if board.winner?(current_player.marker)
      ui.winning_game_message(current_player)
    elsif !board.moves_remaining?
      ui.tie_game_message
    end
  end

  def current_player
    player_one.current_player? ? player_one : player_two
  end

end

class CLIGame < Game

  def play!
    until board.game_over?
      ui.display_board
      move = computer_move? ? get_computer_move : ui.request_human_move
      advance_game if verify_move(move)
    end
    exit_game
  end

  def invalid_move(cell)
    board.valid_cell?(cell) ? ui.taken_cell_message(cell) : ui.bad_cell_message(cell)
  end

  def exit_game
    ui.display_board
    ui.io.exit
  end

end
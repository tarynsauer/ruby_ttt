require './lib/ai'
require './lib/board'
require './lib/player'
require './lib/ui'
require './lib/game_setup'

class Game
  attr_accessor :board, :ui, :player_one, :player_two, :ai, :difficulty_level
  def initialize(board, player_one, player_two, difficulty_level)
    @board      = board
    @ui         = UI.new(@board)
    @player_one = player_one
    @player_two = player_two
    @ai         = AI.new
    @difficulty_level = difficulty_level
  end

  def play!
    until board.game_over?
      ui.display_board
      move = get_next_move
      board.available_cell?(move) ? advance_game(move, current_player) : invalid_move(move)
    end
    exit_game
  end

  def get_next_move
    return ui.request_human_move if current_player.player_type == HUMAN_PLAYER
    difficulty_level == HARD_LEVEL ? ai.computer_move(board, current_player) : board.random_cell
  end

  def advance_game(cell, player)
    board.add_marker(player.marker, cell)
    game_status_check
    player.next_player_turn
    ui.next_move_message(current_player) unless board.game_over?
  end

  def game_status_check
    if board.winner?(current_player.marker)
      ui.winning_game_message(current_player)
    elsif !board.moves_remaining?
      ui.tie_game_message
    end
  end

  def invalid_move(cell)
    board.valid_cell?(cell) ? ui.taken_cell_message(cell) : ui.bad_cell_message(cell)
  end

  def current_player
    player_one.current_player? ? player_one : player_two
  end

  def exit_game
    ui.display_board
    ui.io.exit
  end

end
require './lib/ai'
require './lib/board'
require './lib/player'
require './lib/ui'
require './lib/game_setup'

class Game
  attr_accessor :player_one, :player_two, :board, :game_over, :difficulty_level, :ai, :ui
  def initialize(board, player_one, player_two, difficulty_level)
    @board      = board
    @ui         = UI.new(@board)
    @player_one = player_one
    @player_two = player_two
    @player_one.opponent = @player_two
    @player_two.opponent = @player_one
    @game_over  = false
    @ai         = AI.new
    @difficulty_level = difficulty_level
  end

  def who_goes_first
    if rand(0..1) == 1
      player_one.turn = 1
    else
      player_two.turn = 1
    end
    ui.first_move_message(current_player)
  end

  def game_status_check
    winner_check
    tie_game_check
  end

  def winner_check
    if current_player.winner?(board)
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

  def standardize(input)
    input.split('').sort.join('').upcase
  end

  def current_player
    player_one.turn == 1 ? player_one : player_two
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
    player.add_marker(board, cell)
    game_status_check
    player.next_player_turn
    ui.next_move_message(current_player)
  end

  def get_next_move
    if current_player.player_type == "human"
      standardize(gets.chomp)
    elsif difficulty_level == "hard"
      ai.computer_move(board, current_player)
    else
      board.random_cell
    end
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
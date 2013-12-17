require 'ai'
require 'board'
require 'player'
require 'ui'

EASY_LEVEL = 'easy'
HARD_LEVEL = 'hard'
COMPUTER_PLAYER = 'computer'
HUMAN_PLAYER = 'human'

class Game
  attr_accessor :board, :player_one, :player_two, :ai, :difficulty_level
  def initialize(board, player_one, player_two)
    @board      = board
    @player_one = player_one
    @player_two = player_two
    @ai         = AI.new
    @difficulty_level = nil
  end

  def set_opponents
    player_one.opponent = player_two
    player_two.opponent = player_one
  end

  def computer_player_selected?
    (player_one.player_type == COMPUTER_PLAYER) || (player_two.player_type == COMPUTER_PLAYER)
  end

  def who_goes_first
    rand(0..1) == 1 ? set_first_turn(player_one) : set_first_turn(player_two)
  end

  def set_first_turn(player)
    player.turn = 1
    ui.first_move_message(player)
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
  attr_accessor :ui

  def initialize(board, player_one, player_two)
    super
    @ui = CLIUI.new(board)
  end

  def start_cli_game!
    begin
      set_opponents
      get_player_type(player_one)
      get_player_type(player_two)
      level = get_difficulty_level
      who_goes_first
      play!
    rescue Interrupt
      ui.early_exit_message
      exit
    end
  end

  def get_player_type(player)
    type = ui.request_player_type(player.marker)
    validate_type(type, player) ? set_player_type(type, player) : invalid_type(type, player)
  end

  def get_difficulty_level
    return nil unless computer_player_selected?
    level = ui.request_difficulty_level
    validate_level(level) ? ui.level_assigned_message(level) : invalid_level(level)
  end

  def validate_type(type, player)
    (type == HUMAN_PLAYER) || (type == COMPUTER_PLAYER)
  end

  def set_player_type(type, player)
    player.player_type = type
    ui.type_assigned_message(type, player.marker)
  end

  def invalid_type(type, player)
    ui.invalid_input_message(type)
    get_player_type(player)
  end

  def validate_level(level)
    (level == HARD_LEVEL) || (level == EASY_LEVEL)
  end

  def invalid_level(level)
    ui.invalid_input_message(level)
    get_difficulty_level
  end

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

class WebGame < Game
  attr_accessor :ui

  def initialize(board, player_one, player_two)
    super
    @ui = WebUI.new(board)
  end

  def set_player_types(player_one_type, player_two_type)
    player_one.player_type = player_one_type
    player_two.player_type = player_two_type
  end

end
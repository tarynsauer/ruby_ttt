require 'tictactoe_constants'
require 'ai'
require 'board'
require 'player_factory'
require 'game_setup'
require 'player'
require 'ui'
require 'alpha_beta_player'

class Game
  include TictactoeConstants
  attr_accessor :board, :player_one, :player_two, :ui, :player_first_move
  def initialize(settings)
    @board = settings[:board]
    @player_one = settings[:player_one]
    @player_two = settings[:player_two]
    @player_first_move = settings[:player_first_move]
    @ui = UI.new
  end

  def advance_game
    game_status_check(current_player.opponent.marker)
    ui.next_move_message(current_player.marker) unless board.game_over?
  end

  def game_status_check(marker)
    if board.winner?(marker)
      ui.winning_game_message(marker)
    elsif !board.moves_remaining?
      ui.tie_game_message
    end
  end

  def verify_move(cell)
    return false if !board.available_cell?(cell)
    current_player.add_marker(board, cell)
    true
  end

  def current_player
    if total_markers(TictactoeConstants::MARKER_X) > total_markers(TictactoeConstants::MARKER_O)
      player_two
    elsif total_markers(TictactoeConstants::MARKER_O) > total_markers(TictactoeConstants::MARKER_X)
      player_one
    else
      player_first_move
    end
  end

  def total_markers(marker)
    board.all_cells.select { |cell, value| value == marker }.count
  end

end

class CLIGame < Game
  attr_accessor :board, :player_one, :player_two, :ui, :player_first_move
  def initialize(settings)
    super
    @ui = CLIUI.new
  end

  def start_game!
    begin
      play!
    rescue Interrupt
      ui.early_exit_message
      exit
    end
  end

  def play!
    ui.first_move_message(current_player.marker)
    until board.game_over?
      board.display_board
      get_next_move
    end
    exit_game
  end

  def get_next_move
    if current_player.is_a?(HumanPlayer)
      move = ui.request_human_move
      verify_move(move) ? advance_game : invalid_move(move)
    else
      current_player.make_move(board)
      advance_game
    end
  end

  def invalid_move(cell)
    board.valid_cell?(cell) ? ui.taken_cell_message(cell) : ui.bad_cell_message(cell)
  end

  def exit_game
    board.display_board
    ui.io.exit
  end

end

class WebGame < Game
  attr_accessor :board, :player_one, :player_two, :ui, :player_first_move
  def initialize(settings)
    super
    @ui = UI.new
  end

  def get_message(player)
    return ui.first_move_message(player.marker) if board.empty?
    if board.winner?(current_player.opponent.marker)
      ui.winning_game_message(current_player.opponent.marker)
    elsif !board.moves_remaining?
      ui.tie_game_message
    else
      ui.next_move_message(current_player.marker)
    end
  end

  def get_first_move_player(type_one, type_two)
    PlayerFactory.new(type_one, type_two).player_goes_first
  end

  def computer_player?(type_one, type_two)
    ((type_one.downcase) == TictactoeConstants::COMPUTER_PLAYER) || ((type_two.downcase) == TictactoeConstants::COMPUTER_PLAYER)
  end

end
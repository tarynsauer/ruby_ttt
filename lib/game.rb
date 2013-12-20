require 'ai'
require 'board'
require 'game_setup'
require 'player'
require 'ui'

class Game
  attr_accessor :board, :player_one, :player_two
  def initialize(settings)
    @board = settings[:board]
    @player_one = settings[:player_one]
    @player_two = settings[:player_two]
    @player_first_move = settings[:player_first_move]
  end

  def advance_game
    game_status_check(current_player.marker)
    ui.next_move_message(current_player.marker) unless game_over?
  end

  def game_status_check(marker)
    if winner?(marker)
      ui.winning_game_message(marker)
    elsif !board.moves_remaining?
      ui.tie_game_message
    end
  end

  def verify_move(cell)
    if board.available_cell?(cell)
      current_player.make_move(cell)
      true
    end
  end

  def winner?(marker)
    board_markers = board.all_cells.select { |cell, value| value == marker }.keys
    board.winning_lines.each do |line|
      return true if (line & board_markers).length == board.num_of_rows
    end
    false
  end

  def game_over?
    !board.moves_remaining? || winner?(MARKER_X)|| winner?(MARKER_O)
  end

  def current_player
    if total_markers(MARKER_X) > total_markers(MARKER_O)
      player_two
    elsif total_markers(MARKER_O) > total_markers(MARKER_X)
      player_one
    else
      player_first_move
    end
  end

  def total_markers(marker)
    board.all_cells.keep_if { |cell, value| value == marker }.count
  end

  def get_next_move
    if current_player.is_a?(HumanPlayer)
      ui.request_human_move
    else
      current_player.make_move(board)
    end
  end

end

class CLIGame < Game
  attr_accessor :ui

  def initialize(board, player_one, player_two)
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
    until game_over?
      ui.display_board
      move = get_next_move
      verify_move(move) ? advance_game : invalid_move(move)
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
    @ui = UI.new
  end

end
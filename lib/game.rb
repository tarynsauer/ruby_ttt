require './lib/ai'
require './lib/board'
require './lib/player'
require './lib/ui'

class Game
  attr_accessor :player_one, :player_two, :board, :game_over, :difficulty_level, :ai, :ui
  def initialize(board)
    @board      = board
    @ui         = UI.new(@board)
    @player_one = Player.new('X', get_player_type('X'), @board)
    @player_two = Player.new('O', get_player_type('Y'), @board)
    @player_one.opponent = @player_two
    @player_two.opponent = @player_one
    @game_over  = false
    @ai         = AI.new
    @difficulty_level = get_difficulty_level
  end

  def get_difficulty_level
    return nil unless player_one.player_type == 'computer' || player_two.player_type == 'computer'
    ui.difficulty_level_message
    level = gets.chomp.downcase
    validate_level(level)
  end

  def validate_level(level)
    if (level == 'hard') || (level == 'easy')
      ui.level_assigned_message(level)
      level
    else
      invalid_level(level)
    end
  end

  def invalid_level(level)
    ui.invalid_input_message(level)
    get_difficulty_level
  end

  def who_goes_first
    if rand(0..1) == 1
      player_one.turn = 1
    else
      player_two.turn = 1
    end
    ui.first_move_message(current_player)
  end

  def get_player_type(marker)
    ui.player_type_message(marker)
    type = gets.chomp.downcase
    validate_type(type, marker)
  end

  def validate_type(type, marker)
    if (type == 'human') || (type == 'computer')
      ui.type_assigned_message(type, marker)
      type
    else
      invalid_type(type, marker)
    end
  end

  def invalid_type(type, marker)
    ui.invalid_input_message(type)
    get_player_type(marker)
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
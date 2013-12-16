EASY_LEVEL = 'easy'
HARD_LEVEL = 'hard'
COMPUTER_PLAYER = 'computer'
HUMAN_PLAYER = 'human'

class GameSetup
  attr_accessor :ui, :board, :player_one, :player_two
  def initialize(ui, player_one, player_two)
    @board = ui.board
    @ui = ui
    @player_one = player_one
    @player_two = player_two
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
end

class CLIGameSetup < GameSetup

  def start_cli_game!
    begin
      set_opponents
      get_player_type(player_one)
      get_player_type(player_two)
      level = get_difficulty_level
      who_goes_first
      CLIGame.new(board, ui, player_one, player_two, level).play!
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

end

class WebGameSetup < GameSetup

  def set_player_types(player_one_type, player_two_type)
    player_one.player_type = player_one_type
    player_two.player_type = player_two_type
  end

end
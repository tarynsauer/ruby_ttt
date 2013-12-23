COMPUTER_PLAYER = 'computer'
HUMAN_PLAYER = 'human'
AI_PLAYER = 'hard computer'
HARD_LEVEL = 'hard'
EASY_LEVEL = 'easy'

class GameSetup
  def initialize; end

  def get_settings
    settings = {}
    players = set_up_players
    settings[:board] = get_board
    settings[:player_one] = players.player_one
    settings[:player_two] = players.player_two
    settings[:player_goes_first] = players.player_goes_first
    settings
  end

  def set_up_players; end

  def get_board; end

end

class CLIGameSetup < GameSetup
  attr_accessor :ui
  def initialize
    @ui = CLIUI.new
  end

  def set_up_players
    player_one_type = get_player_type(MARKER_X)
    player_two_type = get_player_type(MARKER_O)
    PlayerFactory.new(player_one_type, player_two_type)
  end

  def get_player_type(marker)
    type = ui.request_player_type(marker)
    validated_type = valid_type?(type) ? get_difficulty_level(type) : invalid_type(type, marker)
    ui.type_assigned_message(validated_type, marker)
    validated_type
  end

  def get_difficulty_level(type)
    return type if type == HUMAN_PLAYER
    level = ui.request_difficulty_level
    valid_level?(level) ? ui.level_assigned_message(level) : invalid_level(level)
    player_type_by_level(level)
  end

  def valid_type?(type)
    (type == HUMAN_PLAYER) || (type == COMPUTER_PLAYER)
  end

  def invalid_type(type, marker)
    ui.invalid_input_message(type)
    get_player_type(marker)
  end

  def valid_level?(level)
    (level == HARD_LEVEL) || (level == EASY_LEVEL)
  end

  def invalid_level(level)
    ui.invalid_input_message(level)
    get_difficulty_level(COMPUTER_PLAYER)
  end

  def player_type_by_level(level)
    level == HARD_LEVEL ? AI_PLAYER : COMPUTER_PLAYER
  end

  def get_board
    rows = ui.request_board_size
    valid_board_size?(rows) ? ui.board_assigned_message(rows) : invalid_board_size(rows)
    CLIBoard.new(rows.to_i)
  end

  def valid_board_size?(input)
    rows = input.to_i
    rows.is_a?(Integer) && (rows > 2 && rows < 6)
  end

  def invalid_board_size(rows)
    ui.invalid_input_message(rows)
    get_board
  end

end

class WebGameSetup < GameSetup

  # def set_up_players(player_one_type, player_two_type)
  #   PlayerFactory.new(player_one_type, player_two_type)
  # end

  # def get_board
  #   board = Board.new(session[:board_size])
  #   board.all_cells = session[:current_board]
  # end

  # def get_settings
  #   settings = {}
  #   players = set_up_players
  #   settings[:board] = get_board
  #   settings[:player_one] = players.player_one
  #   settings[:player_two] = players.player_two
  #   settings[:player_goes_first] = players.player_goes_first
  #   settings
  # end

end
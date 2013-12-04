class GameSetup
  attr_accessor :ui, :board, :player_one, :player_two, :io
  def initialize(board, player_one, player_two)
    @board      = board
    @ui         = UI.new(@board)
    @player_one = player_one
    @player_two = player_two
    @io         = Kernel
  end

  def start_setup!
    set_opponents
    get_player_type(player_one)
    get_player_type(player_two)
    level = get_difficulty_level
    start_new_game(board, player_one, player_two, level)
  end

  def start_new_game(board, player_one, player_two, level)
    Game.new(board, player_one, player_two, level).play!
  end

  def set_opponents
    player_one.opponent = player_two
    player_two.opponent = player_one
  end

  def get_player_type(player)
    type = ui.request_player_type(player.marker)
    validate_type(type, player) ? set_player_type(type, player) : invalid_type(type, player)
  end

  def validate_type(type, player)
    (type == 'human') || (type == 'computer')
  end

  def set_player_type(type, player)
    player.player_type = type
    ui.type_assigned_message(type, player.marker)
  end

  def invalid_type(type, player)
    ui.invalid_input_message(type)
    get_player_type(player)
  end

  def get_difficulty_level
    return nil unless player_one.player_type == 'computer' || player_two.player_type == 'computer'
    level = ui.request_difficulty_level
    validate_level(level) ? set_difficulty_level(level) : invalid_level(level)
  end

  def validate_level(level)
    (level == 'hard') || (level == 'easy')
  end

  def set_difficulty_level(level)
    ui.level_assigned_message(level)
    start_new_game(board, player_one, player_two, level)
  end

  def invalid_level(level)
    ui.invalid_input_message(level)
    get_difficulty_level
  end

end
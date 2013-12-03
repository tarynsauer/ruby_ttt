class GameSetup
  attr_accessor :ui, :board, :player_one, :player_two
  def initialize(board, player_one, player_two)
    @board      = board
    @ui         = UI.new(@board)
    @player_one = player_one
    @player_two = player_two
    setup_game(@board, @player_one, @player_two)
  end

  def setup_game(board, player_one, player_two)
    set_opponents
    set_player_types
    level = get_difficulty_level
    start_new_game(board, player_one, player_two, level)
  end

  def set_opponents
    player_one.opponent = player_two
    player_two.opponent = player_one
  end

  def set_player_types
    get_player_type(player_one)
    get_player_type(player_two)
  end

  def start_new_game(board, player_one, player_two, level)
    Game.new(board, player_one, player_two, level).play!
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

  def get_player_type(player)
    ui.player_type_message(player.marker)
    type = gets.chomp.downcase
    validate_type(type, player)
  end

  def validate_type(type, player)
    if (type == 'human') || (type == 'computer')
      player.player_type = type
      ui.type_assigned_message(type, player.marker)
    else
      invalid_type(type, player)
    end
  end

  def invalid_type(type, player)
    ui.invalid_input_message(type)
    get_player_type(player)
  end

end
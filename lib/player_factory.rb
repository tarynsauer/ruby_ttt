require 'tictactoe_constants'
class PlayerFactory
  include TictactoeConstants
  attr_accessor :player_one, :player_two
  def initialize(type_one, type_two)
    @player_one = create_player(type_one, TictactoeConstants::MARKER_X)
    @player_two = create_player(type_two, TictactoeConstants::MARKER_O)
    set_opponents
  end

  def create_player(type, marker)
    case type
    when TictactoeConstants::COMPUTER_PLAYER
      ComputerPlayer.new(marker)
    when TictactoeConstants::HUMAN_PLAYER
      HumanPlayer.new(marker)
    when TictactoeConstants::AI_PLAYER
      AIPlayer.new(marker)
    else
      raise "Invalid player type"
    end
  end

  def player_goes_first
    rand(0..1) == 1 ? player_one : player_two
  end

  def set_opponents
    player_one.opponent = player_two
    player_two.opponent = player_one
  end

end
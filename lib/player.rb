class Player

  attr_accessor :marker, :turn, :player_type, :board, :opponent
  def initialize(marker, player_type, board)
    @marker = marker
    @player_type = player_type
    @turn = 0
    @board = board
    @opponent = nil
  end

  def next_player_turn
    self.turn = 0
    if self.opponent
      self.opponent.turn = 1
    end
  end

  def color
    if self.turn == 1
      1
    else
      -1
    end
  end

end
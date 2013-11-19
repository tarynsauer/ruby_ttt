class Player

  attr_accessor :marker, :turn, :player_type, :board, :opponent
  def initialize(marker, player_type, board)
    @marker = marker
    @player_type = player_type
    @turn = 0
    @board = board
    @opponent = nil
  end

  def add_marker(cell)
    if board.available_cell?(cell)
      board.filled_spaces[cell] = self.marker
      true
    else
      board.bad_cell_message
      false
    end
  end

  def next_player_turn
    self.turn = 0
    if self.opponent
      self.opponent.turn = 1
    end
  end

end
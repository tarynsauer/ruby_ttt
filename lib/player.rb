class Player
  attr_accessor :marker, :opponent
  def initialize(marker)
    @marker = marker
    @opponent = nil
  end

  def add_marker(board, cell)
    board.all_cells[cell] = self.marker
  end
end

class AIPlayer < Player

  def make_move(board)
    ai = AI.new(self)
    cell = ai.computer_move(board, self)
    add_marker(board, cell)
  end

end

class ComputerPlayer < Player

  def make_move(board)
    cell = board.random_cell
    add_marker(board, cell)
  end

end

class HumanPlayer < Player; end

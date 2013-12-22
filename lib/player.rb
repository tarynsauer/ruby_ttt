class Player
  attr_accessor :marker, :opponent
  def initialize(marker)
    @marker = marker
    @opponent = nil
  end

  def add_marker(board, cell)
    board.all_cells[cell] = self.marker
  end

  def get_alpha(alpha, score)
    alpha
  end

  def get_beta(beta, score)
    beta
  end
end

class AIPlayer < Player

  def make_move(board)
    ai = AI.new(self)
    cell = ai.computer_move(board, self.marker)
    add_marker(board, cell)
  end

end

class ComputerPlayer < Player

  def make_move(game)
    cell = game.board.random_cell
    add_marker(game.board, cell)
  end

end

class HumanPlayer < Player; end

class MinimizingPlayer < Player
  attr_accessor :marker, :opponent
  def initialize(player)
    @marker = player.marker
    @opponent = player.opponent
  end

  def get_alpha(alpha, score)
    score > alpha ? score : alpha
  end

  def return_best_score(alpha, beta)
    alpha
  end
end

class MaximizingPlayer < Player
  attr_accessor :marker, :opponent
  def initialize(player)
    @marker = player.marker
    @opponent = player.opponent
  end

  def get_beta(beta, score)
    score < beta ? score : beta
  end

  def return_best_score(alpha, beta)
    beta
  end
end


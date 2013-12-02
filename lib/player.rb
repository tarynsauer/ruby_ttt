class Player

  attr_accessor :marker, :turn, :player_type, :board, :opponent
  def initialize(marker, player_type, board)
    @marker      = marker
    @player_type = player_type
    @turn        = 0
    @board       = board
    @opponent    = nil
  end

  def next_player_turn
    self.turn = 0
    self.opponent.turn = 1 if self.opponent
  end

end

class Minimizing < Player
  attr_accessor :marker, :turn, :player_type, :board, :opponent
  def initialize(player)
    @marker      = player.marker
    @player_type = player.player_type
    @turn        = player.turn
    @board       = player.board
    @opponent    = player.opponent
  end

  def comparison(score, alpha, beta, best_score)
    alpha = score if score > alpha
    best_score = alpha
  end

  def result(alpha, beta)
    alpha
  end

end

class Maximizing < Player
  attr_accessor :marker, :turn, :player_type, :board, :opponent
  def initialize(player)
    @marker      = player.marker
    @player_type = player.player_type
    @turn        = player.turn
    @board       = player.board
    @opponent    = player.opponent
  end

  def comparison(score, alpha, beta, best_score)
    beta = score if score < beta
    best_score = beta
  end

  def result(alpha, beta)
    beta
  end

end
class Player

  attr_accessor :marker, :turn, :player_type, :opponent
  def initialize(marker)
    @marker      = marker
    @player_type = 'human'
    @turn        = 0
    @opponent    = nil
  end

  def next_player_turn
    self.turn = 0
    self.opponent.turn = 1
  end

  def current_player?
    self.turn == 1
  end

  def get_alpha(alpha, score)
    alpha
  end

  def get_beta(beta, score)
    beta
  end
end

class Minimizing < Player
  attr_accessor :marker, :turn, :opponent
  def initialize(player)
    @marker      = player.marker
    @turn        = player.turn
    @opponent    = player.opponent
  end

  def get_alpha(alpha, score)
    score > alpha ? score : alpha
  end

  def return_value(alpha, beta)
    alpha
  end

end

class Maximizing < Player
  attr_accessor :marker, :turn, :opponent
  def initialize(player)
    @marker      = player.marker
    @turn        = player.turn
    @opponent    = player.opponent
  end

  def get_beta(beta, score)
    score < beta ? score : beta
  end

  def return_value(alpha, beta)
    beta
  end

end


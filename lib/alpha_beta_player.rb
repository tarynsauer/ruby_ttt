class AlphaBetaPlayer
  attr_accessor :marker, :opponent
  def initialize(player)
    @marker = player.marker
    @opponent = player.opponent
  end

  def get_alpha(alpha, score)
    alpha
  end

  def get_beta(beta, score)
    beta
  end
end

class MinimizingPlayer < AlphaBetaPlayer
  def get_alpha(alpha, score)
    score > alpha ? score : alpha
  end

  def return_best_score(alpha, beta)
    alpha
  end
end

class MaximizingPlayer < AlphaBetaPlayer
  def get_beta(beta, score)
    score < beta ? score : beta
  end

  def return_best_score(alpha, beta)
    beta
  end
end
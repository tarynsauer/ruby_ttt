module RubyTictactoe

  class AI
    POS_INF = 999
    NEG_INF = -999
    WIN = 1
    LOSE = -1
    TIE = 0
    attr_reader :current_player
    def initialize(player)
      @current_player = player
    end

    def computer_move(board, player)
      test_board = board.dup
      test_board.all_cells = board.all_cells.dup
      get_best_move(test_board, player)
    end

    def get_best_move(board, player)
      ranked_moves = rank_possible_moves(board, player)
      move = ranked_moves.max_by {|cell, score| score}
      move.first
    end

    private

    def rank_possible_moves(board, player)
      possible_moves = board.open_cells
      possible_moves.each_key do |cell|
        possible_moves[cell] = get_move_score(board, player, cell)
      end
    end

    def get_move_score(board, player, cell)
      player.add_marker(board, cell)
      best_score = apply_minimax(board, player, cell, depth=0, NEG_INF, POS_INF)
      board.remove_marker(cell)
      best_score
    end

    def get_score(board, player)
      return WIN if board.winner?(player.marker) && (player == current_player)
      return LOSE if board.winner?(player.marker)
      TIE
    end

    def apply_minimax(board, player, cell, depth, alpha, beta)
      return get_score(board, player) if board.game_over?
      if (player == current_player)
        maximizing_player = MaximizingPlayer.new(player)
        alphabeta(board, maximizing_player, depth, alpha, beta)
      else
        minimizing_player = MinimizingPlayer.new(player)
        alphabeta(board, minimizing_player, depth, alpha, beta)
      end
    end

    def alphabeta(board, player, depth, alpha, beta)
      board.open_cells.each_key do |cell|
        player.opponent.add_marker(board, cell)
        score = (apply_minimax(board, player.opponent, cell, depth += 1, alpha, beta) / depth.to_f)
        alpha = player.get_alpha(alpha, score)
        beta = player.get_beta(beta, score)
        board.remove_marker(cell)
        break if alpha >= beta
      end
      player.return_best_score(alpha, beta)
    end
  end

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

end
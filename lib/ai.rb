class AI
  POS_INF = 999
  NEG_INF = -999
  WIN     = 1
  LOSE    = -1
  TIE     = 0

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

  def apply_minimax(board, player, cell, depth, alpha, beta)
    return get_score(board, player) if board.game_over?(player)
    if player.turn == 1
      # maximizing_player = Maximizing.new(player)
      max_alphabeta(board, player, depth, alpha, beta)
    else
      # minimizing_player = Minimizing.new(player)
      min_alphabeta(board, player, depth, alpha, beta)
    end
  end

  # def alphabeta(board, player, depth, alpha, beta)
  #   best_score = 0
  #   board.open_cells.each_key do |cell|
  #     player.opponent.add_marker(board, cell)
  #     score = (apply_minimax(board, player.opponent, cell, depth += 1, alpha, beta) / depth.to_f)
  #     player.comparison(score, alpha, beta, best_score)
  #     board.remove_marker(cell)
  #     break if alpha >= beta
  #   end
  #   best_score
  # end

  def min_alphabeta(board, player, depth, alpha, beta)
    board.open_cells.each_key do |cell|
      player.opponent.add_marker(board, cell)
      score = (apply_minimax(board, player.opponent, cell, depth += 1, alpha, beta) / depth.to_f)
      if score > alpha
        alpha = score
      end
      board.remove_marker(cell)
      break if alpha >= beta
    end
    alpha
  end

  def max_alphabeta(board, player, depth, alpha, beta)
    board.open_cells.each_key do |cell|
      player.opponent.add_marker(board, cell)
      score = (apply_minimax(board, player.opponent, cell, depth += 1, alpha, beta) / depth.to_f)
      if score < beta
        beta = score
      end
      board.remove_marker(cell)
      break if alpha >= beta
    end
    beta
  end

  def get_score(board, player)
    return WIN if board.winning_move?(player.marker) && player.turn == 1
    return LOSE if board.winning_move?(player.marker)
    TIE
  end

end
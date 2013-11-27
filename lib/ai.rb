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
    board.add_marker(cell, player.marker)
    best_score = apply_minimax(board, player, cell, depth=0)
    board.remove_marker(cell)
    best_score
  end

  def apply_minimax(board, player, cell, depth)
    return get_score(board, player) if board.game_over?(player)
    player.turn == 1 ? min_alphabeta(board, player, depth, alpha=NEG_INF, beta=POS_INF) : max_alphabeta(board, player, depth, alpha=NEG_INF, beta=POS_INF)
  end

  def min_alphabeta(board, player, depth, alpha, beta)
    board.open_cells.each_key do |cell|
      board.add_marker(cell, player.opponent.marker)
      score = (apply_minimax(board, player.opponent, cell, depth += 1) / depth.to_f)
      beta = score if score < beta
      return beta if alpha >= beta
      board.remove_marker(cell)
    end
    beta
  end

  def max_alphabeta(board, player, depth, alpha, beta)
    board.open_cells.each_key do |cell|
      board.add_marker(cell, player.opponent.marker)
      score = (apply_minimax(board, player.opponent, cell, depth += 1) / depth.to_f)
      alpha = score if score > alpha
      return alpha if alpha >= beta
      board.remove_marker(cell)
    end
    alpha
  end

  def get_score(board, player)
    return WIN if board.winning_move?(player.marker) && player.turn == 1
    return LOSE if board.winning_move?(player.marker)
    TIE
  end

end
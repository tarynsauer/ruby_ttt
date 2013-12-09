class AI
  def initialize
    @@pos_inf = 999
    @@neg_inf = -999
    @@win = 1
    @@lose = -1
    @@tie = 0
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
    board.add_marker(player.marker, cell)
    best_score = apply_minimax(board, player, cell, depth=0, @@neg_inf, @@pos_inf)
    board.remove_marker(cell)
    best_score
  end

  def get_score(board, player)
    return @@win if board.winner?(player.marker) && player.current_player?
    return @@lose if board.winner?(player.marker)
    @@tie
  end

  def apply_minimax(board, player, cell, depth, alpha, beta)
    return get_score(board, player) if board.game_over?
    if player.current_player?
      maximizing_player = Maximizing.new(player)
      alphabeta(board, maximizing_player, depth, alpha, beta)
    else
      minimizing_player = Minimizing.new(player)
      alphabeta(board, minimizing_player, depth, alpha, beta)
    end
  end

  def alphabeta(board, player, depth, alpha, beta)
    board.open_cells.each_key do |cell|
      board.add_marker(player.opponent.marker, cell)
      score = (apply_minimax(board, player.opponent, cell, depth += 1, alpha, beta) / depth.to_f)
      alpha = player.get_alpha(alpha, score)
      beta = player.get_beta(beta, score)
      board.remove_marker(cell)
      break if alpha >= beta
    end
    player.return_value(alpha, beta)
  end

end
class AI

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
    player.turn == 1 ? minimax(board, player, depth).min : minimax(board, player, depth).max
  end

  def minimax(board, player, depth, best_score=[])
    board.open_cells.each_key do |cell1|
      board.add_marker(cell1, player.opponent.marker)
      score = (apply_minimax(board, player.opponent, cell1, depth += 1) / depth.to_f)
      board.remove_marker(cell1)
      best_score.push(score)
    end
    best_score
  end

  def get_score(board, player)
    return 1 if board.winning_move?(player.marker) && player.turn == 1
    return -1 if board.winning_move?(player.marker)
    0
  end

end
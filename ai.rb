class AI

  def computer_move(player, game)
    test_board = game.board.dup
    move = get_best_move(test_board, player, game)
    game.board.add_marker(move, player.marker)
  end

  def get_best_move(board, player, game)
    return board.random_cell if board.get_free_positions.empty?
    possible_moves = board.get_free_positions
    possible_moves.each do |cell, score|
      possible_moves[cell] = minimax_score(game, board, player, cell)
    end
    return possible_moves
    moves = possible_moves.max_by{ |cell, score| score }
    return moves.first
  end

  def minimax_score(game, board, player, cell)
    board.add_marker(cell, player.marker)
    return 1 if board.winning_move?(player.marker) && player == game.current_player
    return -1 if board.winning_move?(player.marker)
    return 0 if board.moves_remaining? == false

    if player == game.current_player
      best = -999
      board.get_free_positions.each_key do |cell_1|
        val = minimax_score(game, board, player.opponent, cell_1)
        best = [best, val].max
        board.remove_marker(cell_1)
      end
      return best
    else
      best = 999
      board.get_free_positions.each_key do |cell_2|
        val = minimax_score(game, board, player, cell_2)
        best = [best, val].min
        board.remove_marker(cell_2)
      end
      return best
    end
  end

end
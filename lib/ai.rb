class AI

  def computer_move(player, game)
    test_board = game.board.dup
    test_board.filled_spaces = game.board.filled_spaces.dup
    move = get_best_move(test_board, player, game)
    game.board.add_marker(move, player.marker)
  end

  def get_best_move(board, player, game)
    depth = 0
    return board.random_cell if board.get_free_positions.empty?
    possible_moves = board.get_free_positions
    possible_moves.each do |cell, score|
      possible_moves[cell] = minimax_score(game, board, player, cell, depth)
    end
    # return possible_moves
    moves = possible_moves.max_by{ |cell, score| score }
    return moves.first
  end

  def minimax_score(game, board, player, cell, depth)
    board.add_marker(cell, player.marker)
    return get_score(game, board, player) if board.game_over?

    if player == game.current_player
      worst = []
      board.get_free_positions.each_key do |cell_1|
        val = minimax_score(game, board, player.opponent, cell_1, depth += 1)
        worst << (val.to_f / depth)
        board.remove_marker(cell_1)
      end
      return (worst.min)
    else
      best = []
      board.get_free_positions.each_key do |cell_2|
        val = minimax_score(game, board, player.opponent, cell_2, depth += 1)
        best << (val.to_f / depth)
        board.remove_marker(cell_2)
      end
      return (best.max)
    end
  end

  private

  def get_score(game, board, player)
    if board.winning_move?(player.marker) && (player == game.current_player)
      1
    elsif board.winning_move?(player.marker)
      -1
    else
      0
    end
  end

end
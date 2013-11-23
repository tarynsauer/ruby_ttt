class AI

  def computer_move(board, player)
    ###return game.board.random_cell if game.board.empty?  ### This line is optional but helps reduce lag.
    test_board = board.dup
    test_board.filled_spaces = board.filled_spaces.dup
    move = get_best_move(test_board, player)
    board.add_marker(move, player.marker)
  end

  def get_best_move(board, player)
    depth = 0
    possible_moves = board.get_free_positions
    possible_moves.each_key do |cell|
      possible_moves[cell] = minimax_score(board, player, cell, depth)
    end
    moves = possible_moves.max_by { |cell, score| score }
    return moves.first
  end

  def minimax_score(board, player, cell, depth)
    board.add_marker(cell, player.marker)
    if board.game_over?
      best_score = get_score(board, player)
    elsif player.turn == 1
      best_score = 999
      board.get_free_positions.each_key do |cell1|
        board.add_marker(cell1, player.opponent.marker)
        score = minimax_score(board, player.opponent, cell1, depth += 1)
        score = (score/depth.to_f)
        if score < best_score
          best_score = score
        end
        board.remove_marker(cell1)
      end
    else
      best_score = -999
      board.get_free_positions.each_key do |cell2|
        board.add_marker(cell2, player.opponent.marker)
        score = minimax_score(board, player.opponent, cell2, depth += 1)
        score = (score/depth.to_f)
        if score > best_score
          best_score = score
        end
        board.remove_marker(cell2)
      end
    end
    board.remove_marker(cell)
    return best_score
  end

  private

  def get_score(board, player)
    if board.winning_move?(player.marker) && (player.turn == 1)
      1
    elsif board.winning_move?(player.marker)
      -1
    else
      0
    end
  end

end
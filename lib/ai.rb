class AI

  def computer_move(player, game)
    test_board = game.board.dup
    test_board.filled_spaces = game.board.filled_spaces.dup
    move = get_best_move(game, test_board, player)
    game.board.add_marker(move, player.marker)
  end

  def get_best_move(game, board, player)
    depth = 0
    possible_moves = board.get_free_positions
    possible_moves.each_key do |cell|
      possible_moves[cell] = minimax_score(game, board, player, cell, depth)
    end
    # return possible_moves
    moves = possible_moves.max_by { |cell, score| score }
    return moves.first
  end

  def minimax_score(game, board, player, cell, depth)
    board.add_marker(cell, player.marker)
    if board.game_over?
      best_score = get_score(game, board, player)
    elsif player == game.current_player
      best_score = 999
      board.get_free_positions.each_key do |cell1|
        board.add_marker(cell1, player.opponent.marker)
        score = minimax_score(game, board, player.opponent, cell1, depth += 1)
        score = (score/depth.to_f)
        if score < best_score
          best_score = score
        end
        board.remove_marker(cell1)
      end
    else
      best_score = -999
      board.get_free_positions.each_key do |cell1|
        board.add_marker(cell1, player.opponent.marker)
        score = minimax_score(game, board, player.opponent, cell1, depth += 1)
        score = (score/depth.to_f)
        if score > best_score
          best_score = score
        end
        board.remove_marker(cell1)
      end
    end
    board.remove_marker(cell)
    return best_score
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
class AI

  def get_free_positions(board)
    board.filled_spaces.select {|k,v| v.nil?}.keys
  end

  def get_max_score(player, game, cell)
    player.add_marker(cell)
    if game.winning_move?(player.marker)
      player.remove_marker(cell)
      1
    else
      player.remove_marker(cell)
      0
    end
  end

  def get_min_score(player, game, cell)
    player.add_marker(cell)
    if game.winning_move?(player.opponent.marker)
      player.remove_marker(cell)
      -1
    else
      player.remove_marker(cell)
      0
    end
  end

  def get_maximized_move(player, game)
    best_move_array = get_free_positions(game.board).select { |cell| get_max_score(player, game, cell) == 1 }
    if best_move_array.length > 0
      best_move_array.first
    # else
    #   get_minimized_move()
    end
  end

  # def get_minimized_move

  # end

end
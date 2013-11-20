class AI

  attr_accessor :board
  def initialize(board)
    @board = board
  end

  def get_free_positions
    board.filled_spaces.select {|k,v| v.nil?}
  end

  def get_computer_move(player, game)
    original_board = board.filled_spaces
    possible_moves = get_free_positions
    possible_moves.each do |cell, score|
      possible_moves[cell] = get_score(player, game, cell, score = 0)
    end
    board = original_board
    moves = possible_moves.max_by{ |cell, score| score }
    moves.first
  end

  def get_score(player, game, cell, score)
    while game.moves_remaining?
      player.add_marker(cell)
      if game.winning_move?(player.marker)
        player.remove_marker(cell)
        return score += 1
      else
        remaining_moves = get_free_positions
        remaining_moves.each_key do |cell_1|
          player.opponent.add_marker(cell_1)
          if game.winning_move?(player.opponent.marker)
            player.remove_marker(cell_1)
            return score -= 1
          else
            remaining_moves = get_free_positions
            remaining_moves.each_key do |cell_2|
              get_score(player, game, cell_2, score)
            end
          end
        end
      end
    end
    score
  end

end
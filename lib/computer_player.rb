module RubyTictactoe

  class ComputerPlayer < Player

    def make_move(board)
      cell = board.random_cell
      add_marker(board, cell)
    end

  end

end
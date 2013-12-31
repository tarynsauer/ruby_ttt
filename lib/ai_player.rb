module RubyTictactoe

  class AIPlayer < Player

    def make_move(board)
      ai = AI.new(self)
      cell = ai.computer_move(board, self)
      add_marker(board, cell)
    end

  end

end
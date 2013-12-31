module RubyTictactoe

  class Player
    attr_accessor :marker, :opponent
    def initialize(marker)
      @marker = marker
      @opponent = nil
    end

    def add_marker(board, cell)
      board.all_cells[cell] = self.marker
    end
  end

end

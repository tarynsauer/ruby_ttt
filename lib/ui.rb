module RubyTictactoe

  class UI
    attr_accessor :io
    def initialize
      @io = Kernel
    end

    def first_move_message(marker)
      "Player '#{marker}' goes first."
    end

    def next_move_message(marker)
      "Player '#{marker}': Make your move."
    end

    def winning_game_message(marker)
      "GAME OVER! Player '#{marker}' wins!"
    end

    def tie_game_message
      "GAME OVER! It's a tie!"
    end

  end

end
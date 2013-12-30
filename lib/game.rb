module RubyTictactoe

  class Game
    include TictactoeConstants
    attr_accessor :board, :player_one, :player_two, :ui, :player_first_move
    def initialize(settings)
      @board = settings[:board]
      @player_one = settings[:player_one]
      @player_two = settings[:player_two]
      @player_first_move = settings[:player_first_move]
      @ui = UI.new
    end

    def advance_game
      game_status_check(current_player.opponent.marker)
      ui.next_move_message(current_player.marker) unless board.game_over?
    end

    def game_status_check(marker)
      if board.winner?(marker)
        ui.winning_game_message(marker)
      elsif !board.moves_remaining?
        ui.tie_game_message
      end
    end

    def verify_move(cell)
      return false if !board.available_cell?(cell)
      current_player.add_marker(board, cell)
      true
    end

    def current_player
      if total_markers(MARKER_X) > total_markers(MARKER_O)
        player_two
      elsif total_markers(MARKER_O) > total_markers(MARKER_X)
        player_one
      else
        player_first_move
      end
    end

    def total_markers(marker)
      board.all_cells.select { |cell, value| value == marker }.count
    end

  end

end
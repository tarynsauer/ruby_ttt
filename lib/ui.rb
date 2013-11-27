class UI
  attr_accessor :board
  def initialize(board)
    @board = board
  end

  def print_board_numbers
    num = 1
    print "    "
    board.num_of_rows.times do
      print "--#{num}-- "
      num += 1
    end
    print "\n"
  end

  def print_divider
    print "   "
    board.num_of_rows.times { print "------" }
    print "\n"
  end

  def print_board_rows
    alpha = 'A'
    board.winning_rows.each do |row|
      show_row(alpha, row)
      alpha = alpha.next
    end
  end

  def show_row(letter, cells)
    print "#{letter}"
    cells.each { |cell| print "  |  " + show_marker(cell) }
    print "  | #{letter}\n"
    print_divider
  end

  def show_marker(cell)
    board.all_cells[cell].nil? ? ' ' : board.all_cells[cell]
  end

  def display_board
    print_board_numbers
    print_board_rows
    print_board_numbers
  end

  def first_move_message(player)
    print "\n\n************ New Game ************\n"
    print "Player '#{player.marker}' goes first.\n"
  end

  def next_move_message(player)
    print "Player '#{player.marker}': Enter open cell ID.\n"
  end

  def winning_game_message(player)
    print "GAME OVER! Player '#{player.marker}' wins!\n"
  end

  def tie_game_message
    print "GAME OVER! It's a tie!\n"
  end

  def taken_cell_message(cell)
    print "#{cell} has already been taken!\n"
  end

  def bad_cell_message(cell)
    print "#{cell} is not a valid cell ID!\n"
  end

end
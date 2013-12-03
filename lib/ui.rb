class UI
  attr_accessor :board, :io
  def initialize(board)
    @board = board
    @io    = Kernel
  end

  def difficulty_level_message
    io.print "Select computer difficulty level: Enter 'easy' or 'hard.'\n"
  end

  def level_assigned_message(level)
    io.print "You selected difficulty level #{level.upcase}.\n"
  end

  def invalid_input_message(input)
    io.print "#{input} is not a valid option."
  end

  def player_type_message(marker)
    io.print "For player " + "'#{marker}'," + " enter 'human' or 'computer.'\n"
  end

  def type_assigned_message(type, marker)
    io.print "Player " + "'#{marker}' " + "is #{type}.\n"
  end

  def print_board_numbers
    num = 1
    io.print "    "
    board.num_of_rows.times do
      io.print "--#{num}-- "
      num += 1
    end
    io.print "\n"
  end

  def print_divider
    io.print "   "
    board.num_of_rows.times { io.print "------" }
    io.print "\n"
  end

  def print_board_rows
    alpha = 'A'
    board.winning_rows.each do |row|
      show_row(alpha, row)
      alpha = alpha.next
    end
  end

  def show_row(letter, cells)
    io.print "#{letter}"
    cells.each { |cell| io.print "  |  " + show_marker(cell) }
    io.print "  | #{letter}\n"
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
    io.print "\n\n************ New Game ************\n"
    io.print "Player '#{player.marker}' goes first.\n"
  end

  def next_move_message(player)
    io.print "Player '#{player.marker}': Enter open cell ID.\n"
  end

  def winning_game_message(player)
    io.print "GAME OVER! Player '#{player.marker}' wins!\n"
  end

  def tie_game_message
    io.print "GAME OVER! It's a tie!\n"
  end

  def taken_cell_message(cell)
    io.print "#{cell} has already been taken!\n"
  end

  def bad_cell_message(cell)
    io.print "#{cell} is not a valid cell ID!\n"
  end

end
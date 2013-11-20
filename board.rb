class Board
  attr_accessor :filled_spaces
  def initialize
    @filled_spaces = { '1A' => nil, '2A' => nil, '3A' => nil,
                       '1B' => nil, '2B' => nil, '3B' => nil,
                       '1C' => nil, '2C' => nil, '3C' => nil }
  end

  def display_board
    show_rowA(show_marker('1A'), show_marker('2A'), show_marker('3A'))
    show_rowB(show_marker('1B'), show_marker('2B'), show_marker('3B'))
    show_rowC(show_marker('1C'), show_marker('2C'), show_marker('3C'))
  end

  def show_rowA(cell1, cell2, cell3)
    print "  --1-- --2-- --3--\n"
    print "A |" + " " + cell1 + " " + "| " + "|" + " " + cell2 + " " + "| " + "|" + " " + cell3 + " " + "| A\n"
  end

  def show_rowB(cell1, cell2, cell3)
    print "  ----- ----- -----\n"
    print "B |" + " " + cell1 + " " + "| " + "|" + " " + cell2 + " " + "| " + "|" + " " + cell3 + " " + "| B\n"
  end

  def show_rowC(cell1, cell2, cell3)
    print "  ----- ----- -----\n"
    print "C |" + " " + cell1 + " " + "| " + "|" + " " + cell2 + " " + "| " + "|" + " " + cell3 + " " + "| C\n"
    print "  --1-- --2-- --3--\n"
  end

  def show_marker(cell)
    if filled_spaces[cell].nil?
      ' '
    else
      filled_spaces[cell]
    end
  end

  def available_cell?(cell)
    valid_cell?(cell) && filled_spaces[cell].nil?
  end

  def valid_cell?(cell)
    filled_spaces.has_key?(cell)
  end

  def first_move_message(player)
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
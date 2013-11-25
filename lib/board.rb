class Board
  attr_accessor :all_cells
  def initialize
    @all_cells = { '1A' => nil, '2A' => nil, '3A' => nil,
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
    if all_cells[cell].nil?
      ' '
    else
      all_cells[cell]
    end
  end

  def available_cell?(cell)
    valid_cell?(cell) && all_cells[cell].nil?
  end

  def valid_cell?(cell)
    all_cells.has_key?(cell)
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

  def add_marker(cell, marker)
    all_cells[cell] = marker
  end

  def remove_marker(cell)
    all_cells[cell] = nil
  end

  def moves_remaining?
    all_cells.has_value?(nil)
  end

  def winning_move?(marker)
    winning_lines = [['1A', '1B', '1C'], ['2A', '2B', '2C'], ['3A', '3B', '3C'],
                     ['1A', '2A', '3A'], ['1B', '2B', '3B'], ['1C', '2C', '3C'],
                     ['1C', '2B', '3A'], ['1A', '2B', '3C']]
    board_markers = all_cells.select { |k,v| v == marker }.keys
    winning_lines.each do |line|
      if (line & board_markers).length == 3
        return true
      end
    end
    false
  end

  def game_over?(player)
    !moves_remaining? || winning_move?(player.marker)|| winning_move?(player.opponent.marker)
  end

  def open_cells
    all_cells.select {|k,v| v.nil?}
  end

  def empty?
    open_cells.length == 9
  end

  def random_cell
    cells = open_cells.keys
    cells_count = cells.length - 1
    cells[rand(cells_count)]
  end

end
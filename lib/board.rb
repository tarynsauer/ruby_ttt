MARKER_X = 'X'
MARKER_O = 'O'

class Board
  attr_accessor :all_cells, :num_of_rows, :winning_lines
  def initialize(num_of_rows)
    @num_of_rows = num_of_rows
    @all_cells = create_board_hash
    @winning_lines = get_winning_lines
  end

  def create_board_hash
    new_board = Hash.new
    alpha = 'A'
    numeric = 1
    num_of_rows.times do
      num_of_rows.times do
        cellID = numeric.to_s + alpha
        numeric += 1
        new_board[cellID] = nil
      end
      alpha = alpha.next
      numeric = 1
    end
    new_board
  end

  def get_winning_lines
    lines = []
    all_rows.each { |row| lines << row }
    all_cols.each { |col| lines << col }
    diagonals.each { |diagonal| lines << diagonal }
    lines
  end

  def all_rows
    rows = []
    cellIDs = all_cells.keys
    beg = 0
    ending  = num_of_rows - 1
    until rows.length == num_of_rows
      rows << cellIDs[beg..ending]
      beg += num_of_rows
      ending += num_of_rows
    end
    rows
  end

  def add_test_marker(marker, cell)
    all_cells[cell] = marker
  end

  def available_cell?(cell)
    valid_cell?(cell) && all_cells[cell].nil?
  end

  def valid_cell?(cell)
    all_cells.has_key?(cell)
  end

  def remove_marker(cell)
    all_cells[cell] = nil
  end

  def moves_remaining?
    all_cells.has_value?(nil)
  end

  def winner?(marker)
    board_markers = all_cells.select { |cell, value| value == marker }.keys
    winning_lines.each do |line|
      return true if (line & board_markers).length == num_of_rows
    end
    false
  end

  def game_over?
    !moves_remaining? || winner?(MARKER_X) || winner?(MARKER_O)
  end

  def open_cells
    all_cells.select { |k,v| v.nil? }
  end

  def empty?
    open_cells.length == (num_of_rows * num_of_rows)
  end

  def random_cell
    cells = open_cells.keys
    cells_count = cells.length - 1
    cells[rand(cells_count)]
  end

  private
  def all_cols
    cols = []
    index = 0
    num_of_rows.times do
      cols << get_column(index)
      index += 1
    end
    cols
  end

  def get_column(index)
    column = []
    cellIDs = all_cells.keys
    num_of_rows.times do
      column << cellIDs[index]
      index += num_of_rows
    end
    column
  end

  def diagonals
    diagonals = []
    diagonals << diagonal_one
    diagonals << diagonal_two
  end

  def diagonal_one
    diagonal = []
    alpha = 'A'
    numeric = 1
    num_of_rows.times do
      diagonal << numeric.to_s + alpha
      alpha = alpha.next
      numeric += 1
    end
    diagonal
  end

  def diagonal_two
    diagonal = []
    alpha = 'A'
    numeric = num_of_rows
    num_of_rows.times do
      diagonal << numeric.to_s + alpha
      alpha = alpha.next
      numeric -= 1
    end
    diagonal
  end

end

class CLIBoard < Board
  attr_accessor :all_cells, :num_of_rows, :winning_lines, :io
  def initialize(num_of_rows)
    super
    @io = Kernel
  end

  def print_board_numbers
    num = 1
    io.print "    "
    num_of_rows.times do
      io.print "--#{num}-- "
      num += 1
    end
    io.print "\n"
  end

  def print_divider
    io.print "   "
    num_of_rows.times { io.print "------" }
    io.print "\n"
  end

  def print_board_rows
    alpha = 'A'
    all_rows.each do |row|
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
    all_cells[cell].nil? ? ' ' : all_cells[cell]
  end

  def display_board
    print_board_numbers
    print_board_rows
    print_board_numbers
  end

end

class WebBoard < Board

  def print_active_board
    board_string = ''
    all_rows.each do |row|
      board_string += "<div class='row'>"
      row.each { |cell| board_string += "<button name='move' value='#{cell}'> #{all_cells[cell]} <span class='cell'>.</span></button>" }
      board_string += "</div>"
    end
    board_string
  end

  def print_inactive_board
    board_string = ''
    all_rows.each do |row|
      board_string += "<div class='row'>"
      row.each { |cell| board_string += "<button> #{all_cells[cell]} <span class='cell'>.</span></button>" }
      board_string += "</div>"
    end
    board_string
  end

end
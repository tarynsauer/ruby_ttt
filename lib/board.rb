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

  def add_marker(marker, cell)
    all_cells[cell] = marker
  end

  def winner?(marker)
    board_markers = all_cells.select { |k,v| v == marker }.keys
    winning_lines.each do |line|
      return true if (line & board_markers).length == num_of_rows
    end
    false
  end

  def game_over?
    !moves_remaining? || winner?(MARKER_X)|| winner?(MARKER_O)
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
class Board
  attr_accessor :all_cells, :num_of_rows, :winning_lines
  def initialize(num_of_rows)
    @num_of_rows   = num_of_rows
    @all_cells     = create_board_hash
    @winning_lines = get_winning_lines
  end

  def create_board_hash
    new_board    = Hash.new
    alpha        = 'A'
    numeric      = 1
    num_of_rows.times do
      num_of_rows.times do
        key       = numeric.to_s + alpha
        numeric  += 1
        new_board[key] = nil
      end
      alpha   = alpha.next
      numeric = 1
    end
    new_board
  end

  def get_winning_lines
    lines = []
    winning_rows.each { |row| lines << row }
    winning_cols.each { |col| lines << col }
    winning_diagonals.each { |diagonal| lines << diagonal }
    lines
  end

  def winning_rows
    rows   = []
    cells  = all_cells.keys
    beg    = 0
    ending = num_of_rows - 1
    until rows.length == num_of_rows
      rows << cells[beg..ending]
      beg += num_of_rows
      ending += num_of_rows
    end
    rows
  end

  def winning_cols
    cols   = []
    index  = 0
    num_of_rows.times do
      cols << get_col(index)
      index += 1
    end
    cols
  end

  def get_col(index)
    col   = []
    cells = all_cells.keys
    num_of_rows.times do
      col << cells[index]
      index += num_of_rows
    end
    col
  end

  def winning_diagonals
    diagonals = []
    diagonals << get_diag_one
    diagonals << get_diag_two
  end

  def get_diag_one
    diagonal = []
    alpha    = 'A'
    numeric  = 1
    num_of_rows.times do
      diagonal << numeric.to_s + alpha
      alpha = alpha.next
      numeric += 1
    end
    diagonal
  end

  def get_diag_two
    diagonal = []
    alpha    = 'A'
    numeric  = num_of_rows
    num_of_rows.times do
      diagonal << numeric.to_s + alpha
      alpha = alpha.next
      numeric -= 1
    end
    diagonal
  end

  def available_cell?(cell)
    valid_cell?(cell) && all_cells[cell].nil?
  end

  def valid_cell?(cell)
    all_cells.has_key?(cell)
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
    board_markers = all_cells.select { |k,v| v == marker }.keys
    winning_lines.each do |line|
      return true if (line & board_markers).length == num_of_rows
    end
    false
  end

  def game_over?(player)
    !moves_remaining? || winning_move?(player.marker)|| winning_move?(player.opponent.marker)
  end

  def open_cells
    all_cells.select { |k,v| v.nil? }
  end

  def empty?
    open_cells.length == (num_of_rows * num_of_rows)
  end

  def random_cell
    cells       = open_cells.keys
    cells_count = cells.length - 1
    cells[rand(cells_count)]
  end

end
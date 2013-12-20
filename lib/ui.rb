class UI
  def initialize; end

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

class CLIUI < UI
  attr_accessor :io
  def initialize
    @io = Kernel
  end

  def request_player_type(marker)
    player_type_message(marker)
    io.gets.chomp.downcase
  end

  def request_difficulty_level
    difficulty_level_message
    io.gets.chomp.downcase
  end

  def request_board_size
    board_size_message
    io.gets.chomp.downcase
  end

  def request_human_move
    standardize(io.gets.chomp)
  end

  def standardize(input)
    input.split('').sort.join('').upcase
  end

  def difficulty_level_message
    io.print "Select computer difficulty level: Enter 'easy' or 'hard.'\n"
  end

  def board_size_message
    io.print "Enter the number of rows you want your board to have (3-5).\n"
  end

  def level_assigned_message(level)
    io.print "You selected difficulty level #{level.upcase}.\n"
  end

  def board_assigned_message(rows)
    io.print "You selected a board with #{rows} rows.\n"
  end

  def invalid_input_message(input)
    io.print " #{input} is not a valid option.\n"
  end

  def player_type_message(marker)
    io.print "For player " + "'#{marker}'," + " enter 'human' or 'computer.'\n"
  end

  def type_assigned_message(type, marker)
    io.print "Player " + "'#{marker}' " + "is #{type}.\n"
  end

  def first_move_message(marker)
    output = super
    io.print "\n\n************ New Game ************\n"
    io.print output + "\n"
  end

  def next_move_message(marker)
    io.print "Player '#{marker}': Enter open cell ID.\n"
  end

  def winning_game_message(marker)
    output = super
    io.print output + "\n"
  end

  def tie_game_message
    output = super
    io.print output + "\n"
  end

  def taken_cell_message(cell)
    io.print "#{cell} has already been taken!\n"
  end

  def bad_cell_message(cell)
    io.print "#{cell} is not a valid cell ID!\n"
  end

  def early_exit_message
    io.print "\nExiting Tic-Tac-Toe..."
    io.print "...\n"
    io.print "Goodbye!\n\n"
  end

end
require './lib/ai'
require './lib/board'
require './lib/game'
require './lib/player'

class Game

  attr_accessor :player_one, :player_two, :board, :game_over, :ai
  def initialize(player_one_type, player_two_type, board)
    @board      = board
    @player_one = Player.new('X', player_one_type, @board)
    @player_two = Player.new('O', player_two_type, @board)
    @player_one.opponent = @player_two
    @player_two.opponent = @player_one
    @game_over  = false
    @ai         = AI.new
  end

  def who_goes_first
    if rand(0..1) == 1
      player_one.turn = 1
    else
      player_two.turn = 1
    end
    board.first_move_message(current_player)
  end

  def self.get_player_type(marker)
    print "For player " + "'#{marker}'," + " enter 'human' or 'computer.'\n"
    type = gets.chomp.downcase
    if (type == 'human') || (type == 'computer')
      print "Player " + "'#{marker}' " + "is #{type}.\n"
    else
      print "#{type} is not a valid option."
      self.get_player_type(marker)
    end
    type
  end

  def game_status_check
    if board.winning_move?(current_player.marker)
      board.winning_game_message(current_player)
      exit_game
    elsif !board.moves_remaining?
      board.tie_game_message
      exit_game
    end
  end

  def current_player
    player_one.turn == 1 ? player_one : player_two
  end

  def standardize(input)
    input.split('').sort.join('').upcase
  end

  def exit_game
    board.display_board
    game_over = true
    exit
  end

  def play!
    who_goes_first
    until game_over
      board.next_move_message(current_player)
      board.display_board
      if current_player.player_type == "human"
        user_input = gets.chomp
        move = standardize(user_input)
        if board.available_cell?(move)
          board.add_marker(move, current_player.marker)
          game_status_check
          current_player.next_player_turn
        elsif board.valid_cell?(move)
          board.taken_cell_message(move)
        else
          board.bad_cell_message(move)
        end
      else
        move = ai.computer_move(board, current_player)
        board.add_marker(move, current_player.marker)
        game_status_check
        current_player.next_player_turn
      end
    end
  end

end

# player_1 = Game.get_player_type('X')
# player_2 = Game.get_player_type('O')
# Game.new(player_1, player_2, Board.new).play!
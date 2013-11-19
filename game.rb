require './ai'
require './board'
require './game'
require './line'
require './player'

class Game

  attr_reader :player_one, :player_two, :board, :game_over
  def initialize(player_one_type, player_two_type, board)
    @board      = board
    @player_one = Player.new('X', player_one_type, @board)
    @player_two = Player.new('O', player_two_type, @board)
    @player_one.opponent = @player_two
    @player_two.opponent = @player_one
    @game_over  = false
  end

  def who_goes_first
    if rand(0..1) == 1
      player_one.turn = 1
      board.first_move_message(player_one)
    else
      player_two.turn = 1
      board.first_move_message(player_two)
    end
  end

  # def game_over

  # end

  def current_player
    if player_one.turn == 1
      player_one
    else
      player_two
    end
  end

  def start_game
    who_goes_first
    until game_over
      board.next_move_message(current_player)
      board.display_board
      move = gets.chomp.upcase
      current_player.add_marker(move)
      current_player.next_player_turn
    end
  end

end

board = Board.new
Game.new('human', 'human', board).start_game
require './lib/game'

board      = Board.new(3)
player_one = Player.new('X', board)
player_two = Player.new('O', board)
GameSetup.new(board, player_one, player_two)

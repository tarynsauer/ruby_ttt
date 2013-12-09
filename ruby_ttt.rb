require './lib/game'

board      = Board.new(3)
player_one = Player.new(MARKER_X)
player_two = Player.new(MARKER_O)
GameSetup.new(board, player_one, player_two).start!

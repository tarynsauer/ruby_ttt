require './lib/game'

player_1 = Game.get_player_type('X')
player_2 = Game.get_player_type('O')
Game.new(player_1, player_2, Board.new(3)).play!
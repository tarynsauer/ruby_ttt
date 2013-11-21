require 'spec_helper'

describe 'AI' do

  before :each do
    @board = Board.new
    @game = Game.new('computer', 'computer', @board)
    @player_x = @game.player_one
    @player_o = @game.player_two
  end

  # describe '#get_best_move' do
  #   [
  #     [{ "1A"=>'X', "2A"=>'X', "3A"=>'O',
  #        "1B"=>nil, "2B"=>'O', "3B"=>'O',
  #        "1C"=>'X', "2C"=>'O', "3C"=>'X' }, '1B'],
  #     [{ "1A"=>'X', "2A"=>nil, "3A"=>'O',
  #        "1B"=>'O', "2B"=>'O', "3B"=>'X',
  #        "1C"=>'X', "2C"=>'X', "3C"=>'O' }, '2A'],
  #     [{ "1A"=>'X', "2A"=>nil, "3A"=>'O',
  #        "1B"=>'O', "2B"=>'O', "3B"=>nil,
  #        "1C"=>'X', "2C"=>'X', "3C"=>'O' }, '3B'],
  #     [{ "1A"=> nil, "2A"=>'X', "3A"=>'O',
  #        "1B"=> nil, "2B"=>'O', "3B"=> 'O',
  #        "1C"=>'X', "2C"=>nil, "3C"=> nil }, '1B'],
  #     [{ "1A"=> nil, "2A"=>'O', "3A"=>'O',
  #        "1B"=> nil, "2B"=>nil, "3B"=> 'X',
  #        "1C"=> nil, "2C"=>nil, "3C"=> nil }, '1A'],
  #   ].each do |board_filled_spaces, expected_outcome|
  #     it "gets #{board_filled_spaces} and returns #{expected_outcome}" do
  #       @board.filled_spaces = board_filled_spaces
  #       @player_x.turn = 1
  #       @game.ai.get_best_move(@board, @player_x, @game).should == expected_outcome
  #     end
  #   end
  # end

  describe '#minimax_score' do
    [
      [{ "1A"=>'X', "2A"=>'X', "3A"=>'O',
         "1B"=>nil, "2B"=>'O', "3B"=>'O',
         "1C"=>'X', "2C"=>'O', "3C"=>'X' }, '1B', 1],
      [{ "1A"=>'X', "2A"=>nil, "3A"=>'O',
         "1B"=>'O', "2B"=>'O', "3B"=>'X',
         "1C"=>'X', "2C"=>'X', "3C"=>'O' }, '2A', 0],
      [{ "1A"=>'X', "2A"=>nil, "3A"=>'O',
         "1B"=>'O', "2B"=>'O', "3B"=>nil,
         "1C"=>'X', "2C"=>'X', "3C"=>'O' }, '2A', -1],
      [{ "1A"=> nil, "2A"=>'X', "3A"=>'O',
         "1B"=> nil, "2B"=>'O', "3B"=> 'O',
         "1C"=>'X', "2C"=>nil, "3C"=> nil }, '1A', -1],
      [{ "1A"=> nil, "2A"=>'X', "3A"=>'O',
         "1B"=> nil, "2B"=>'O', "3B"=> 'O',
         "1C"=>'X', "2C"=>nil, "3C"=> nil }, '2C', -1],
    ].each do |board_filled_spaces, cellID, expected_outcome|
      it "gets #{board_filled_spaces} and #{cellID} and returns #{expected_outcome}" do
        @board.filled_spaces = board_filled_spaces
        @player_x.turn = 1
        @game.ai.minimax_score(@game, @board, @player_x, cellID).should == expected_outcome
      end
    end
  end

  describe '#minimax_score' do
    [
      [{ "1A"=>'X', "2A"=>'X', "3A"=>'O',
         "1B"=>nil, "2B"=>'O', "3B"=>'O',
         "1C"=>'X', "2C"=>nil, "3C"=>nil }, '1B', 1],
      [{ "1A"=>nil, "2A"=>nil, "3A"=>'O',
         "1B"=>'O', "2B"=>'O', "3B"=>'X',
         "1C"=>'X', "2C"=>'X', "3C"=>'O' }, '2A', -1],
    ].each do |board_filled_spaces, cellID, expected_outcome|
      it "gets #{board_filled_spaces} and #{cellID} and returns #{expected_outcome}" do
        @board.filled_spaces = board_filled_spaces
        @player_x.turn = 1
        @game.ai.minimax_score(@game, @board, @player_x, cellID).should == expected_outcome
      end
    end
  end


end
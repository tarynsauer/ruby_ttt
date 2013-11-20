require 'spec_helper'

describe 'AI' do

  before :each do
    @board = Board.new
    @game = Game.new('computer', 'computer', @board)
    @player_x = @game.player_one
    @player_o = @game.player_two
  end

  describe '#get_free_positions' do
    it "gets hash of cell IDs of open positions" do
      @game.ai.get_free_positions.should == {"1A"=>nil, "2A"=>nil, "3A"=>nil, "1B"=>nil, "2B"=>nil, "3B"=>nil, "1C"=>nil, "2C"=>nil, "3C"=>nil}
    end

    it "gets hash of cell IDs of open positions" do
      @player_x.add_marker("1A")
      @game.ai.get_free_positions.should == {"2A"=>nil, "3A"=>nil, "1B"=>nil, "2B"=>nil, "3B"=>nil, "1C"=>nil, "2C"=>nil, "3C"=>nil}
    end

    it "gets hash of cell IDs of open positions" do
      @player_x.add_marker("1A")
      @player_o.add_marker("2A")
      @game.ai.get_free_positions.should == {"3A"=>nil, "1B"=>nil, "2B"=>nil, "3B"=>nil, "1C"=>nil, "2C"=>nil, "3C"=>nil}
    end
  end

  describe '#get_score' do
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
    ].each do |board_filled_spaces, cellID, expected_outcome|
      it "gets #{board_filled_spaces} and #{cellID} and returns #{expected_outcome}" do
        @board.filled_spaces = board_filled_spaces
        @game.ai.get_score(@player_x, @game, cellID, 0).should == expected_outcome
      end
    end
  end

  describe '#get_computer_move' do
    [
      [{ "1A"=>'X', "2A"=>'X', "3A"=>'O',
         "1B"=>nil, "2B"=>'O', "3B"=>'O',
         "1C"=>'X', "2C"=>'O', "3C"=>'X' }, '1B'],
      [{ "1A"=>'X', "2A"=>nil, "3A"=>'O',
         "1B"=>'O', "2B"=>'O', "3B"=>'X',
         "1C"=>'X', "2C"=>'X', "3C"=>'O' }, '2A'],
      [{ "1A"=>'X', "2A"=>nil, "3A"=>'O',
         "1B"=>'O', "2B"=>'O', "3B"=>nil,
         "1C"=>'X', "2C"=>'X', "3C"=>'O' }, '3B'],
      [{ "1A"=> nil, "2A"=>'X', "3A"=>'O',
         "1B"=> nil, "2B"=>'O', "3B"=> 'O',
         "1C"=>'X', "2C"=>nil, "3C"=> nil }, '1B'],
    ].each do |board_filled_spaces, expected_outcome|
      it "gets #{board_filled_spaces} and returns #{expected_outcome}" do
        @board.filled_spaces = board_filled_spaces
        @game.ai.get_computer_move(@player_x, @game).should == expected_outcome
      end
    end
  end

end
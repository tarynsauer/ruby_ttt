require 'spec_helper'

describe 'AI' do

  before :each do
    @board = Board.new
    @game = Game.new('computer', 'computer', @board)
    @player_x = @game.player_one
    @player_o = @game.player_two
  end

  describe '#get_free_positions' do
    it "gets array of cell IDs of open positions" do
      @game.ai.get_free_positions(@board).should == ["1A", "2A", "3A", "1B", "2B", "3B", "1C", "2C", "3C"]
    end

    it "gets array of cell IDs of open positions" do
      @player_x.add_marker("1A")
      @game.ai.get_free_positions(@board).should == ["2A", "3A", "1B", "2B", "3B", "1C", "2C", "3C"]
    end

    it "gets array of cell IDs of open positions" do
      @player_x.add_marker("1A")
      @player_o.add_marker("2A")
      @game.ai.get_free_positions(@board).should == ["3A", "1B", "2B", "3B", "1C", "2C", "3C"]
    end
  end

  describe '#get_max_score' do

    it 'returns a value of one for a winning move' do
      @board.filled_spaces = { "1A"=>'X', "2A"=>nil, "3A"=>'O',
                               "1B"=>nil, "2B"=>'O', "3B"=>nil,
                               "1C"=>'X', "2C"=>nil, "3C"=>nil }
      @game.ai.get_max_score(@player_x, @game, '1B').should == 1
    end

    it 'returns a value of zero for a non-winning move' do
      @board.filled_spaces = { "1A"=>'X', "2A"=>nil, "3A"=>'O',
                               "1B"=>nil, "2B"=>'O', "3B"=>nil,
                               "1C"=>'X', "2C"=>nil, "3C"=>nil }
      @game.ai.get_max_score(@player_x, @game, '2A').should == 0
    end

    it 'removes marker before returning a 0 score' do
      @board.filled_spaces = { "1A"=>'X', "2A"=>nil, "3A"=>'O',
                               "1B"=>nil, "2B"=>'O', "3B"=>nil,
                               "1C"=>'X', "2C"=>nil, "3C"=>nil }
      @game.ai.get_max_score(@player_x, @game, '2A')
      @board.filled_spaces.should == { "1A"=>'X', "2A"=>nil, "3A"=>'O',
                               "1B"=>nil, "2B"=>'O', "3B"=>nil,
                               "1C"=>'X', "2C"=>nil, "3C"=>nil }
    end

    it 'removes marker before returning a 1 score' do
      @board.filled_spaces = { "1A"=>'X', "2A"=>nil, "3A"=>'O',
                               "1B"=>nil, "2B"=>'O', "3B"=>nil,
                               "1C"=>'X', "2C"=>nil, "3C"=>nil }
      @game.ai.get_max_score(@player_x, @game, '1B')
      @board.filled_spaces.should == { "1A"=>'X', "2A"=>nil, "3A"=>'O',
                               "1B"=>nil, "2B"=>'O', "3B"=>nil,
                               "1C"=>'X', "2C"=>nil, "3C"=>nil }
    end
  end

  describe '#get_maximized_move' do

    it 'returns the first open cell with a score of 1' do
      @board.filled_spaces = { "1A"=>'X', "2A"=>nil, "3A"=>'O',
                               "1B"=>nil, "2B"=>'O', "3B"=>nil,
                               "1C"=>'X', "2C"=>nil, "3C"=>nil }
      @game.ai.get_maximized_move(@player_x, @game).should == '1B'
    end
  end

end
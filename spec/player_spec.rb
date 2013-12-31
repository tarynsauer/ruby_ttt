require 'spec_helper'

describe 'Player' do

  before :each do
    @board = MockBoard.new
    @player_x = RubyTictactoe::Player.new('X')
    @player_o = RubyTictactoe::Player.new('O')
  end

  describe '#add_marker' do
    it "adds the player X's marker to the board" do
      @player_x.add_marker(@board, '1A')
      @board.all_cells.should == { '1A' => 'X', '2A' => nil, '3A' => nil,
                                   '1B' => nil, '2B' => nil, '3B' => nil,
                                   '1C' => nil, '2C' => nil, '3C' => nil }
    end

    it "adds the player O's marker to the board" do
      @player_o.add_marker(@board, '2A')
      @board.all_cells.should == { '1A' => nil, '2A' => 'O', '3A' => nil,
                                   '1B' => nil, '2B' => nil, '3B' => nil,
                                   '1C' => nil, '2C' => nil, '3C' => nil }
    end
  end

end
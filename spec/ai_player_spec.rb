require 'spec_helper'

describe 'AIPlayer' do

  before :each do
    @board = RubyTictactoe::Board.new(3)
    player_o = RubyTictactoe::HumanPlayer.new('O')
    @player = RubyTictactoe::AIPlayer.new('X')
    @player.opponent = player_o
    player_o.opponent = @player
  end

  describe '#make_move' do
    it "adds cell from #computer_move to the board" do
      @player.make_move(@board)
      @board.all_cells.should == { '1A' => 'X', '2A' => nil, '3A' => nil,
                                   '1B' => nil, '2B' => nil, '3B' => nil,
                                   '1C' => nil, '2C' => nil, '3C' => nil }
    end
  end

end
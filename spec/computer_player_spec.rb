require 'spec_helper'

describe 'ComputerPlayer' do

  before :each do
    @board = RubyTictactoe::Board.new(3)
    @player = RubyTictactoe::ComputerPlayer.new('X')
  end

  describe '#make_move' do
    it "random cell to open spot on the board" do
      @board.all_cells = { '1A' => 'O', '2A' => 'X', '3A' => 'O',
                           '1B' => 'O', '2B' => 'O', '3B' => 'X',
                           '1C' => 'X', '2C' => 'X', '3C' => nil }
      @player.make_move(@board)
      @board.all_cells.should == { '1A' => 'O', '2A' => 'X', '3A' => 'O',
                                   '1B' => 'O', '2B' => 'O', '3B' => 'X',
                                   '1C' => 'X', '2C' => 'X', '3C' => 'X' }
    end
  end

end
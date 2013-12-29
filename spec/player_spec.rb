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
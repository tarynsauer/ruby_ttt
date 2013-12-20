require 'spec_helper'

describe 'Player' do

  before :each do
    @board = MockBoard.new
    @player_x = Player.new('X')
    @player_o = Player.new('O')
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

  describe '#get_alpha' do
    it 'returns the alpha value' do
      @player_x.get_alpha(3, 1).should == 3
    end
  end

  describe '#get_beta' do
    it 'returns the beta value' do
      @player_x.get_beta(2, 1).should == 2
    end
  end

end

describe 'AIPlayer' do

  before :each do
    @board = MockBoard.new
    @player = AIPlayer.new('X')
    @player.ai = MockAI
  end

  describe '#make_move' do
    it "adds cell from #computer_move to the board" do
      @player.make_move(@board)
      @board.all_cells.should == { '1A' => nil, '2A' => 'X', '3A' => nil,
                                   '1B' => nil, '2B' => nil, '3B' => nil,
                                   '1C' => nil, '2C' => nil, '3C' => nil }
    end
  end

end

describe 'ComputerPlayer' do

  before :each do
    @board = Board.new(3)
    @player = ComputerPlayer.new('X')
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

describe 'MinimizingPlayer' do
  before :each do
    @player_o = AIPlayer.new('O')
    @min_player = MinimizingPlayer.new(@player_o)
  end

  describe '#get_alpha' do
    it "returns the largest value" do
      @min_player.get_alpha(1, 2.5).should == 2.5
    end

    it "returns the largest value" do
      @min_player.get_alpha(1, -2.5).should == 1
    end
  end

  describe '#return_best_score' do
    it 'returns alpha value' do
      @min_player.return_best_score(2, 3).should == 2
    end
  end

end

describe 'MaximizingPlayer' do
  before :each do
    @player_o = AIPlayer.new('O')
    @max_player = MaximizingPlayer.new(@player_o)
  end

  describe '#get_beta' do
    it "returns the smallest value" do
      @max_player.get_beta(1, 2.5).should == 1
    end

    it "returns the smallest value" do
      @max_player.get_beta(1, -2.5).should == -2.5
    end
  end

  describe '#return_best_score' do
    it 'returns beta value' do
      @max_player.return_best_score(2, 3).should == 3
    end
  end

end
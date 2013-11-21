require 'spec_helper'

describe 'Board' do

  before :each do
    @board = Board.new
    @game = Game.new('human', 'human', @board)
    @player_x = @game.player_one
    @player_o = @game.player_two
    @board.add_marker('1B', @player_x.marker)
  end

  describe '#add_marker' do
    it "adds player's marker to the board" do
      @board.add_marker('1A', @player_x.marker)
      @board.filled_spaces['1A'].should == 'X'
    end

    it "adds player's marker to the board" do
      @board.add_marker('1B', @player_o.marker)
      @board.filled_spaces['1B'].should == 'O'
    end
  end

  describe '#remove_marker' do
    it "removes player's marker from the board" do
      @board.remove_marker('1B')
      @board.filled_spaces['1B'].should == nil
    end
  end

  describe '#available_cell?' do
    it "returns true if the cell is empty" do
      @board.available_cell?('1A').should == true
    end

    it "returns false if the cell is not empty" do
      @board.available_cell?('1B').should == false
    end

    it "returns false if the cell ID is invalid" do
      @board.available_cell?('test').should == false
    end
  end

  describe '#valid_cell?' do
    it "returns false if the cell is invalid" do
      @board.valid_cell?('test').should == false
    end

    it "returns true if the cell is valid" do
      @board.valid_cell?('1B').should == true
    end

    it "returns true if the cell is valid" do
      @board.valid_cell?('1A').should == true
    end
  end

  describe '#moves_remaining?' do
    it "returns false if board is full" do
      @board.filled_spaces = { '1A' => 'X', '2A' => 'O', '3A' => 'X',
                       '1B' => "O", '2B' => 'O', '3B' => 'X',
                       '1C' => 'X', '2C' => 'O', '3C' => 'X' }
      @board.moves_remaining?.should == false
    end

    it "returns true if board is not full" do
      @board.filled_spaces = { '1A' => 'X', '2A' => 'O', '3A' => 'X',
                       '1B' => "O", '2B' => 'O', '3B' => 'X',
                       '1C' => 'X', '2C' => 'O', '3C' => nil }
      @board.moves_remaining?.should == true
    end
  end

  describe '#winning_move?' do
    [
      [{ '1A' => nil, '2A' => 'X', '3A' => 'O',
         '1B' => 'X', '2B' => 'O', '3B' => 'X',
         '1C' => 'O', '2C' => nil, '3C' => nil }, true],
      [{ '1A' => 'O', '2A' => 'X', '3A' => nil,
         '1B' => 'O', '2B' => nil, '3B' => 'X',
         '1C' => 'O', '2C' => 'X', '3C' => nil }, true],
      [{ '1A' => 'O', '2A' => 'O', '3A' => 'O',
         '1B' => nil, '2B' => 'X', '3B' => 'X',
         '1C' => nil, '2C' => nil, '3C' => nil }, true],
      [{ '1A' => 'O', '2A' => 'X', '3A' => 'O',
         '1B' => 'O', '2B' => 'O', '3B' => 'X',
         '1C' => 'X', '2C' => 'X', '3C' => 'O' }, true],
      [{ '1A' => nil, '2A' => 'X', '3A' => 'O',
         '1B' => 'X', '2B' => nil, '3B' => 'X',
         '1C' => 'O', '2C' => nil, '3C' => nil }, false],
      [{ '1A' => 'O', '2A' => 'X', '3A' => nil,
         '1B' => 'X', '2B' => nil, '3B' => 'X',
         '1C' => 'O', '2C' => 'X', '3C' => nil }, false]
    ].each do |board_filled_spaces, expected_outcome|
      it "gets #{board_filled_spaces} and returns #{expected_outcome}" do
        @board.filled_spaces = board_filled_spaces
        @board.winning_move?('O').should == expected_outcome
      end
    end
  end

  describe '#get_free_positions' do
    before :each do
      @board = Board.new
      @game = Game.new('human', 'human', @board)
      @player_x = @game.player_one
      @player_o = @game.player_two
    end

    it "gets hash of cell IDs of open positions" do
      @board.get_free_positions.should == {"1A"=>nil, "2A"=>nil, "3A"=>nil, "1B"=>nil, "2B"=>nil, "3B"=>nil, "1C"=>nil, "2C"=>nil, "3C"=>nil}
    end

    it "gets hash of cell IDs of open positions" do
      @board.add_marker("1A", @player_x.marker)
      @board.get_free_positions.should == {"2A"=>nil, "3A"=>nil, "1B"=>nil, "2B"=>nil, "3B"=>nil, "1C"=>nil, "2C"=>nil, "3C"=>nil}
    end

    it "gets hash of cell IDs of open positions" do
      @board.add_marker("1A", @player_x.marker)
      @board.add_marker("2A", @player_o.marker)
      @board.get_free_positions.should == {"3A"=>nil, "1B"=>nil, "2B"=>nil, "3B"=>nil, "1C"=>nil, "2C"=>nil, "3C"=>nil}
    end
  end

  describe '#get_free_positions' do
    before :each do
      @board = Board.new
      @game = Game.new('human', 'human', @board)
      @player_x = @game.player_one
      @player_o = @game.player_two
    end

    it "gets hash of cell IDs of open positions" do
      @board.empty?.should == true
    end

    it "gets hash of cell IDs of open positions" do
      @board.add_marker('1A', @player_x.marker)
      @board.empty?.should == false
    end

  end

  describe '#random_cell' do
    before :each do
      @board = Board.new
      @game = Game.new('human', 'human', @board)
      @player_x = @game.player_one
      @player_o = @game.player_two
    end

    it "gets hash of cell IDs of open positions" do
      @board.random_cell.should be_an_instance_of(String)
    end

  end

end
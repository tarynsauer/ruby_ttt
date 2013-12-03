require 'spec_helper'

describe 'Board' do

  before :each do
    @board = Board.new(3)
    @player_x = Player.new('X', @board)
    @player_o = Player.new('O', @board)
    @player_x.add_marker(@board, '1B')
  end

  describe '#remove_marker' do
    it "removes player's marker from the board" do
      @board.remove_marker('1B')
      @board.all_cells['1B'].should == nil
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
      @board.all_cells = { '1A' => 'X', '2A' => 'O', '3A' => 'X',
                       '1B' => "O", '2B' => 'O', '3B' => 'X',
                       '1C' => 'X', '2C' => 'O', '3C' => 'X' }
      @board.moves_remaining?.should == false
    end

    it "returns true if board is not full" do
      @board.all_cells = { '1A' => 'X', '2A' => 'O', '3A' => 'X',
                       '1B' => "O", '2B' => 'O', '3B' => 'X',
                       '1C' => 'X', '2C' => 'O', '3C' => nil }
      @board.moves_remaining?.should == true
    end
  end

  describe '#open_cells' do
    before :each do
      @board = Board.new(3)
      @player_x = Player.new('X', @board)
      @player_o = Player.new('O', @board)
    end

    it "gets hash of cell IDs of open positions" do
      @board.open_cells.should == {"1A"=>nil, "2A"=>nil, "3A"=>nil, "1B"=>nil, "2B"=>nil, "3B"=>nil, "1C"=>nil, "2C"=>nil, "3C"=>nil}
    end

    it "gets hash of cell IDs of open positions" do
      @player_x.add_marker(@board, "1A")
      @board.open_cells.should == {"2A"=>nil, "3A"=>nil, "1B"=>nil, "2B"=>nil, "3B"=>nil, "1C"=>nil, "2C"=>nil, "3C"=>nil}
    end

    it "gets hash of cell IDs of open positions" do
      @player_x.add_marker(@board, "1A")
      @player_o.add_marker(@board, "2A")
      @board.open_cells.should == {"3A"=>nil, "1B"=>nil, "2B"=>nil, "3B"=>nil, "1C"=>nil, "2C"=>nil, "3C"=>nil}
    end
  end

  describe '#open_cells' do
    before :each do
      @board = Board.new(3)
      @player_x = Player.new('X', @board)
      @player_o = Player.new('O', @board)
    end

    it "gets hash of cell IDs of open positions" do
      @board.empty?.should == true
    end

    it "gets hash of cell IDs of open positions" do
      @player_x.add_marker(@board, '1A')
      @board.empty?.should == false
    end

  end

  describe '#random_cell' do
    before :each do
      @board = Board.new(3)
      @player_x = Player.new('X', @board)
      @player_o = Player.new('O', @board)
    end

    it "gets hash of cell IDs of open positions" do
      @board.random_cell.should be_an_instance_of(String)
    end

  end

end
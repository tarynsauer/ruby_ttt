require 'spec_helper'

describe 'Board' do

  before :each do
    @board = Board.new
    @game = Game.new('human', 'human', @board)
    player_x = @game.player_one
    player_o = @game.player_two
    player_x.add_marker('1B')
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

end
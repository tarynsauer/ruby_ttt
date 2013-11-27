require 'spec_helper'

describe 'Game' do

  before :each do
    @board = Board.new(3)
    @game  = Game.new('human', 'human', @board)
    @game.player_one.turn = 1
  end

  def setup_board(moves)
    moves.each do |move|
      board.add_marker(move)
    end
  end

  it 'is a basic test' do
    # arrange
    # act
    # assert
  end

  describe '#current_player' do
    it "returns player with a turn value of 1" do
      @game.current_player.should == @game.player_one
    end
  end

  describe '#standardize' do
    it "returns cell ID in the correct format" do
      @game.standardize('1a').should == '1A'
    end

    it "returns cell ID in the correct format" do
      @game.standardize('a1').should == '1A'
    end
  end

end
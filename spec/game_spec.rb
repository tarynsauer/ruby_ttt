require 'spec_helper'

describe 'Game' do

  before :each do
    board = double('board')
    player_one = double(:turn => 1)
    player_two = double(:turn => 0)
    @game = Game.new(board, player_one, player_two, 'hard')
  end

  # def setup_board(moves)
  #   moves.each do |move|
  #     board.add_marker(move)
  #   end
  # end

  describe '#current_player' do
    it "returns player with a turn value of 1" do
      @game.current_player.should == @game.player_one
    end

    it "does not return player with a value of 0" do
      @game.current_player.should_not == @game.player_two
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
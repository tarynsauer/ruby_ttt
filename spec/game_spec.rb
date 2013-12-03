require 'spec_helper'

describe 'Game' do

  before :each do
    board = double('board')
    @game = TestGame.new(board)
  end

  # def setup_board(moves)
  #   moves.each do |move|
  #     board.add_marker(move)
  #   end
  # end

  describe '#current_player' do
    it "returns player with a turn value of 1" do
      @game.player_one.turn = 1
      @game.current_player.should == @game.player_one
    end

    it "does not return player with a value of 0" do
      @game.player_one.turn = 1
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

  describe '#get_difficulty_level' do
    it "returns nil when both players are human" do
      ### pending
      @game.get_difficulty_level.should == nil
    end
  end

end
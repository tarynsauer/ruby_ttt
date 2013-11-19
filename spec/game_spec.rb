require 'spec_helper'

describe 'Game' do

  # before :each do

  # end

  describe '#current_player' do
    it "returns player with a turn value of 1" do
      @board = Board.new()
      @game = Game.new('human', 'human', @board)
      @game.player_one.turn = 1
      @game.current_player.should == @game.player_one
    end
  end

end
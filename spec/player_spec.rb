require 'spec_helper'

describe 'Player' do

  before :each do
    @board    = Board.new
    @game = Game.new('human', 'human', @board)
    @player_x = @game.player_one
    @player_o = @game.player_two
  end

  describe '#add_marker' do
    it "adds player's marker to the board" do
      @player_x.add_marker('1A')
      @board.filled_spaces['1A'].should == 'X'
    end

    it "adds player's marker to the board" do
      @player_o.add_marker('1B')
      @board.filled_spaces['1B'].should == 'O'
    end

    it "calls bad cell message if cell input is taken" do

    end

    it "calls bad cell message if cell input is taken" do

    end

  end

  describe '#next_player_turn' do
    before :each do
      @player_o.turn = 1
      @player_x.turn = 1
      @player_x.next_player_turn
    end
    it "changes current player's turn value to 0" do
      @player_x.turn.should == 0
    end

    it "changes opponent's turn value to 1" do
      @player_o.turn.should == 1
    end

  end

end
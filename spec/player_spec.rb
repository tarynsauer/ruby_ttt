require 'spec_helper'

describe 'Player' do

  before :each do
    @board = MockBoard.new
    @player_x = Player.new('X', @board)
    @player_o = Player.new('O', @board)
    @player_x.opponent = @player_o
    @player_o.opponent = @player_x
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
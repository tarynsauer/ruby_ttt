require 'spec_helper'

describe 'GameSetup' do

  before :each do
    @board      = MockBoard
    @player_x   = MockPlayer.new('X', @board)
    @player_o   = MockPlayer.new('O', @board)
    @game_setup = GameSetup.new(@board, @player_x, @player_o)
  end

  describe '#set_opponents' do
    it "assigns player o as player x opponent" do
      @game_setup.set_opponents
      expect(@player_x.opponent).to eq(@player_o)
    end

    it "assigns player o as player x opponent" do
      @game_setup.set_opponents
      expect(@player_o.opponent).to eq(@player_x)
    end
  end

end
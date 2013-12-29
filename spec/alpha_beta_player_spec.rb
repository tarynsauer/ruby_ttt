require 'spec_helper'

describe 'RubyTictactoe::AlphaBetaPlayer' do

  before :each do
    @board = MockBoard.new
    player_x = MockPlayer.new('X')
    player_o = MockPlayer.new('O')
    player_x.opponent = player_o
    player_o.opponent = player_x
    @player_x = RubyTictactoe::AlphaBetaPlayer.new(player_x)
    @player_o = RubyTictactoe::AlphaBetaPlayer.new(player_o)
  end

  describe '#get_alpha' do
    it 'returns the alpha value' do
      @player_x.get_alpha(3, 1).should == 3
    end
  end

  describe '#get_beta' do
    it 'returns the beta value' do
      @player_x.get_beta(2, 1).should == 2
    end
  end

end

describe 'RubyTictactoe::MinimizingPlayer' do
  before :each do
    @player_o = MockPlayer.new('O')
    @min_player = RubyTictactoe::MinimizingPlayer.new(@player_o)
  end

  describe '#get_alpha' do
    it "returns the largest value" do
      @min_player.get_alpha(1, 2.5).should == 2.5
    end

    it "returns the largest value" do
      @min_player.get_alpha(1, -2.5).should == 1
    end
  end

  describe '#return_best_score' do
    it 'returns alpha value' do
      @min_player.return_best_score(2, 3).should == 2
    end
  end

end

describe 'RubyTictactoe::MaximizingPlayer' do
  before :each do
    @player_o = MockPlayer.new('O')
    @max_player = RubyTictactoe::MaximizingPlayer.new(@player_o)
  end

  describe '#get_beta' do
    it "returns the smallest value" do
      @max_player.get_beta(1, 2.5).should == 1
    end

    it "returns the smallest value" do
      @max_player.get_beta(1, -2.5).should == -2.5
    end
  end

  describe '#return_best_score' do
    it 'returns beta value' do
      @max_player.return_best_score(2, 3).should == 3
    end
  end

end
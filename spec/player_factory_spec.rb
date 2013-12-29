require 'spec_helper'

describe 'RubyTictactoe::PlayerFactory' do
  before :each do
    @factory = RubyTictactoe::PlayerFactory.new(RubyTictactoe::TictactoeConstants::COMPUTER_PLAYER, RubyTictactoe::TictactoeConstants::HUMAN_PLAYER)
  end

  describe '#create_player' do
    it 'assigns player_one to a new ComputerPlayer' do
      @factory.player_one.is_a?(RubyTictactoe::ComputerPlayer)
    end

    it 'assigns player_two to a new HumanPlayer' do
      @factory.player_one.is_a?(RubyTictactoe::HumanPlayer)
    end

    it 'assigns player_one to a new AIPlayer' do
      @factory = RubyTictactoe::PlayerFactory.new(RubyTictactoe::TictactoeConstants::AI_PLAYER, RubyTictactoe::TictactoeConstants::HUMAN_PLAYER)
      @factory.player_one.is_a?(RubyTictactoe::AIPlayer)
    end

    it 'raises an Invalid type error when type is invalid' do
      expect { RubyTictactoe::PlayerFactory.new('bad_type', RubyTictactoe::TictactoeConstants::HUMAN_PLAYER) }.to raise_error("Invalid player type")
    end
  end

  describe '#set_opponents' do
    it 'assigns player_two to player_one opponent' do
      @factory.player_one.opponent.should == @factory.player_two
    end

    it 'assigns player_one to player_two opponent' do
      @factory.player_one.opponent.should == @factory.player_two
    end
  end

  describe '#player_goes_first' do
    it 'returns a player object' do
      @factory.player_goes_first.is_a?(RubyTictactoe::Player)
    end
  end

end
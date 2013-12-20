require 'spec_helper'

describe 'PlayerFactory' do
  before :each do
    @factory = PlayerFactory.new(COMPUTER_PLAYER, HUMAN_PLAYER)
  end

  describe '#create_player' do
    it 'assigns player_one to a new ComputerPlayer' do
      @factory.player_one.is_a?(ComputerPlayer)
    end

    it 'assigns player_two to a new HumanPlayer' do
      @factory.player_one.is_a?(HumanPlayer)
    end

    it 'assigns player_one to a new AIPlayer' do
      @factory = PlayerFactory.new(AI_PLAYER, HUMAN_PLAYER)
      @factory.player_one.is_a?(AIPlayer)
    end

    it 'raises an Invalid type error when type is invalid' do
      pending
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
      @factory.player_goes_first.is_a?(Player)
    end
  end

end
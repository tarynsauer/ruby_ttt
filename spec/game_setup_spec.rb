require 'spec_helper'

describe 'GameSetup' do

  before :each do
    @setup = CLIGameSetup.new
    @setup.ui.io = MockKernel
  end

  describe '#set_up_players' do
    before :each do
      @setup.ui.io.set_gets('Human')
    end

    it 'returns a PlayerFactory object' do
      @setup.set_up_players.is_a?(PlayerFactory)
    end
  end

  describe '#get_player_type' do
    before :each do
      @setup.ui.io.set_gets('Human')
    end

    it 'returns validated player type string' do
      @setup.get_player_type('X').should == 'human'
    end

    it 'prints type assigned message' do
      @setup.ui.io.last_print_call.should include("Player 'X' is human.")
    end

    it 'prints invalid input message for invalid type' do
      @setup.ui.io.set_gets('other')
      @setup.get_player_type('O')
      @setup.ui.io.last_print_call.should include("invalid")
    end
  end

  describe '#get_difficulty_level' do
    it 'returns human if human player type' do
      pending
    end

  end

end
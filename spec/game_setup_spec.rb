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

  context 'validation methods' do
    describe '#validate_type' do
      it 'returns true if type is valid' do
        validation_result = @game_setup.validate_type('human', @player_x)
        expect(validation_result).to be_true
      end

      it 'returns true if type is valid' do
        validation_result = @game_setup.validate_type('computer', @player_x)
        expect(validation_result).to be_true
      end

      it 'returns false if type is not valid' do
        validation_result = @game_setup.validate_type('nothing', @player_x)
        expect(validation_result).to be_false
      end
    end

    describe '#validate_level' do
      it 'returns true if level is valid' do
        validation_result = @game_setup.validate_level('easy')
        expect(validation_result).to be_true
      end

      it 'returns true if level is valid' do
        validation_result = @game_setup.validate_level('hard')
        expect(validation_result).to be_true
      end

      it 'returns false if level is not valid' do
        validation_result = @game_setup.validate_level('nothing')
        expect(validation_result).to be_false
      end
    end
  end

  context 'set setting methods' do

    describe '#set_player_type' do
      it 'assigns type to player object' do
        @player_x.player_type = 'human'
        @game_setup.set_player_type('computer', @player_x)
        expect(@player_x.player_type).to eq('computer')
      end

      it 'calls #type_assigned_message' do
        @game_setup.ui = MockUI.new(@board)
        @game_setup.set_player_type('computer', @player_x)
        expect(@game_setup.ui.type_assigned_message_called).to eq(1)
      end
    end

  end

end
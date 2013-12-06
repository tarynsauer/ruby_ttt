require 'spec_helper'

describe 'GameSetup' do

  before :each do
    @board      = MockBoard.new
    @player_x   = MockPlayer.new('X', @board)
    @player_o   = MockPlayer.new('O', @board)
    @game_setup = GameSetup.new(@board, @player_x, @player_o)
    @game_setup.ui.io = MockKernel
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

  context 'get methods' do
    describe '#get_player_type' do
      it "sets player type when user input is valid" do
        @game_setup.ui.io.set_gets('computer')
        @game_setup.get_player_type(@player_x)
        expect(@player_x.player_type).to eq('computer')
      end
    end

    describe '#get_difficulty_level' do
      it "returns nil when both players are human" do
        @player_x.player_type = 'human'
        @player_o.player_type = 'human'
        level = @game_setup.get_difficulty_level
        expect(level).to be_nil
      end
    end
  end

  describe '#who_goes_first' do
    before :each do
      @player_x.turn = 0
      @player_o.turn = 0
    end
    it "sets turn value to one for one of the players" do
      @game_setup.who_goes_first
      expect((@player_x.turn == 1) || (@player_o.turn == 1)).to be_true
    end

    it "sets turn value to one for only one player" do
      @game_setup.who_goes_first
      expect((@player_x.turn == 1) && (@player_o.turn == 1)).to be_false
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

  context 'setting methods' do

    describe '#set_player_type' do
      it 'assigns type to player object' do
        @player_x.player_type = 'human'
        @game_setup.set_player_type('computer', @player_x)
        expect(@player_x.player_type).to eq('computer')
      end
    end

    describe '#set_first_turn' do
      it 'assigns type to player object' do
        @game_setup.set_first_turn(@player_x)
        expect(@game_setup.ui.io.last_print_call).to include("Player 'X' goes first")
      end

      it 'assigns type to player object' do
        @player_x.turn = 0
        @game_setup.set_first_turn(@player_x)
        expect(@player_x.turn).to eq(1)
      end
    end

  end

end
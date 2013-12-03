require 'spec_helper'

describe 'GameSetup' do

  context 'Game setup methods' do
    before :each do
      @board      = double('board')
      @player_x   = Player.new('X', @board)
      @player_o   = Player.new('O', @board)
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

    describe '#set_player_types' do
      it "calls #get_player_type twice" do
        expect(@game_setup).to receive(:get_player_type).twice
        @game_setup.set_player_types
      end
    end

    describe '#get_difficulty_level' do
      it "returns nil with two human players" do
        level = @game_setup.get_difficulty_level
        expect(level).to be_nil
      end

      it "calls #difficulty_level_message once with one computer player" do
        @player_x.player_type = 'computer'
        expect(@game_setup.ui).to receive(:difficulty_level_message).once
        @game_setup.stub(:gets) {"hard"}
        @game_setup.get_difficulty_level
      end

      it "calls #validate_level once with user input string" do
        @player_x.player_type = 'computer'
        @game_setup.stub(:gets) {"hard"}
        @game_setup.should_receive(:validate_level).with("hard")
        @game_setup.get_difficulty_level
      end
    end

    describe '#validate_level' do
      it "calls #invalid_level with invalid input" do
        @game_setup.should_receive(:invalid_level).with("invalid")
        @game_setup.validate_level('invalid')
      end

      it "calls #level_assigned_message with valid input" do
        @game_setup.ui.should_receive(:level_assigned_message).with("easy")
        @game_setup.validate_level('easy')
      end

      it "returns level string with valid input" do
        output = @game_setup.validate_level('easy')
        expect(output).to eq('easy')
      end
    end

    describe '#invalid_level' do
      it "calls #invalid_input_message" do
        @game_setup.ui.should_receive(:invalid_input_message).with("test")
        @game_setup.invalid_level("test")
      end

      it "calls #get_difficulty_level" do
        @game_setup.should_receive(:get_difficulty_level).once
        @game_setup.invalid_level("test")
      end
    end

    describe '#get_player_type' do
      it "calls #player_type_message once" do
        expect(@game_setup.ui).to receive(:player_type_message).once
        @game_setup.stub(:gets) {"human"}
        @game_setup.get_player_type(@player_o)
      end

      it "calls #validate_type once" do
        @game_setup.stub(:gets) {"human"}
        expect(@game_setup).to receive(:validate_type).once
        @game_setup.get_player_type(@player_o)
      end
    end

    describe '#validate_type' do
      it "assigns type to player when type is valid" do
        @game_setup.validate_type('computer', @player_o)
        expect(@player_o.player_type).to eq('computer')
      end

      it "calls #type_assigned_message once when type is valid" do
        @game_setup.ui.should_receive(:type_assigned_message).once
        @game_setup.validate_type('computer', @player_o)
      end

      it "calls #invalid_type once when type is invalid" do
        @game_setup.should_receive(:invalid_type).once
        @game_setup.validate_type('awesome', @player_o)
      end
    end

    describe '#invalid_type' do
      it "calls #invalid_input_type once" do
        @game_setup.stub(:gets) {"human"}
        expect(@game_setup.ui).to receive(:invalid_input_message).once
        @game_setup.invalid_type('bad_type', @player_o)
      end

      it "calls #get_player_type once" do
        @game_setup.stub(:gets) {"human"}
        expect(@game_setup).to receive(:get_player_type).once
        @game_setup.invalid_type('bad_type', @player_o)
      end
    end
  end
end
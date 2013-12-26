require 'spec_helper'

describe 'GameSetup' do

  before :each do
    @setup = CLIGameSetup.new
    @setup.ui.io = MockKernel
  end

  describe '#get_settings' do
    it 'returns hash with settings values' do
      @setup = GameSetup.new
      @setup.get_settings.is_a?(Hash)
    end
  end

  describe '#set_up_players' do
    it 'returns a PlayerFactory object' do
      @setup.ui.io.set_gets('Human')
      @setup.set_up_players.is_a?(PlayerFactory)
    end
  end

  describe '#get_player_type' do
    it 'returns validated player type string' do
      @setup.get_player_type('X').should == 'human'
    end

    it 'prints type assigned message' do
      @setup.ui.io.last_print_call.should include("Player 'X' is human.")
    end
  end

  context 'validation methods' do
    describe '#valid_type?' do
      it 'returns true if type is valid' do
        @setup.valid_type?('human').should be_true
      end

      it 'returns true if type is valid' do
        @setup.valid_type?('computer').should be_true
      end

      it 'returns false if type is not valid' do
        @setup.valid_type?('nothing').should be_false
      end
    end

    describe '#valid_level?' do
      it 'returns true if level is valid' do
        @setup.valid_level?('easy').should be_true
      end

      it 'returns true if level is valid' do
        @setup.valid_level?('hard').should be_true
      end

      it 'returns false if level is not valid' do
        @setup.valid_level?('nothing').should be_false
      end
    end

    describe '#valid_board_size?' do
      it 'returns true if board size is valid' do
        @setup.valid_board_size?('3').should be_true
      end

      it 'returns false if board size is invalid' do
        @setup.valid_board_size?('8').should be_false
      end

      it 'returns false if board size is invalid' do
        @setup.valid_board_size?('nothing').should be_false
      end
    end
  end

  context 'invalid input methods' do
    describe '#invalid_type' do
      before :each do
        @setup.ui.io.set_gets('Human')
      end

      it 'prints invalid message to screen' do
        @setup.invalid_type('baddd', 'X')
        expect(@setup.ui.io.last_lines(4)).to include('baddd is not a valid option')
      end

      it 'prints player type message to the screen' do
        @setup.invalid_type('baddd', 'X')
        expect(@setup.ui.io.last_lines(4)).to include("For player 'X', enter 'human' or 'computer.")
      end
    end

    describe '#invalid_level' do
      before :each do
        @setup.ui.io.set_gets('easy')
      end

      it 'prints invalid message to screen' do
        @setup.invalid_level('wrong')
        expect(@setup.ui.io.last_lines(4)).to include('wrong is not a valid option')
      end

      it 'prints difficulty level message to the screen' do
        @setup.invalid_level('baddd')
        expect(@setup.ui.io.last_lines(4)).to include("difficulty level")
      end
    end

    describe '#invalid_board_size' do
      before :each do
        @setup.ui.io.set_gets('3')
      end
      it 'prints invalid message to screen' do
        @setup.invalid_board_size('wrong')
        expect(@setup.ui.io.last_lines(4)).to include('wrong is not a valid option')
      end

      it 'prints board size message to the screen' do
        @setup.invalid_board_size('baddd')
        expect(@setup.ui.io.last_lines(4)).to include("number of rows you want")
      end
    end
  end

end

describe 'WebGameSetup' do
    before :each do
      @setup = WebGameSetup.new
    end

  describe '#set_up_players' do
    it 'returns a PlayerFactory object' do
      players = @setup.set_up_players('human', 'computer')
      players.is_a?(PlayerFactory)
    end
  end

  describe '#get_first_move_player' do
    it '#get_first_move_player returns a Player object' do
      player = @setup.get_first_move_player('human', 'computer')
      player.is_a?(Player)
    end
  end

  describe '#get_board' do
    it 'returns a Board object' do
      board = @setup.get_board(3, {} )
      board.is_a?(WebBoard)
    end
  end

end
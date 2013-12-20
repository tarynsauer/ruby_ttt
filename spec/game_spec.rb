require 'spec_helper'

describe 'Game' do

  context 'game setup methods' do

    before :each do
      @board = MockBoard.new
      @player_x = MockPlayer.new('X')
      @player_o = MockPlayer.new('O')
      @game = CLIGame.new(@board, @player_x, @player_o)
      @game.ui.io = MockKernel
    end

    describe '#set_opponents' do
      it "assigns player o as player x opponent" do
        @game.set_opponents
        expect(@player_x.opponent).to eq(@player_o)
      end

      it "assigns player o as player x opponent" do
        @game.set_opponents
        expect(@player_o.opponent).to eq(@player_x)
      end
    end

    context 'get methods' do
      describe '#get_player_type' do
        it "sets player type when user input is valid" do
          @game.ui.io.set_gets('computer')
          @game.get_player_type(@player_x)
          expect(@player_x.player_type).to eq('computer')
        end
      end

      describe '#get_difficulty_level' do
        it "returns nil when both players are human" do
          @player_x.player_type = 'human'
          @player_o.player_type = 'human'
          level = @game.get_difficulty_level
          expect(level).to be_nil
        end

        # it "calls #level_assigned_message when level is valid" do
        #   @player_x.player_type = 'human'
        #   @player_o.player_type = 'computer'
        #   @game.ui.io.set_gets('easy')
        #   @game.get_difficulty_level
        #   expect(@game.ui.io.last_print_call).should include('You selected difficulty level')
        # end
      end
    end

      describe '#winner? returns correct boolean value' do
    [
      [{ '1A' => nil, '2A' => 'X', '3A' => 'O',
         '1B' => 'X', '2B' => 'O', '3B' => 'X',
         '1C' => 'O', '2C' => nil, '3C' => nil }, true],
      [{ '1A' => 'O', '2A' => 'X', '3A' => nil,
         '1B' => 'O', '2B' => nil, '3B' => 'X',
         '1C' => 'O', '2C' => 'X', '3C' => nil }, true],
      [{ '1A' => 'O', '2A' => 'O', '3A' => 'O',
         '1B' => nil, '2B' => 'X', '3B' => 'X',
         '1C' => nil, '2C' => nil, '3C' => nil }, true],
      [{ '1A' => 'O', '2A' => 'X', '3A' => 'O',
         '1B' => 'O', '2B' => 'O', '3B' => 'X',
         '1C' => 'X', '2C' => 'X', '3C' => 'O' }, true],
      [{ '1A' => nil, '2A' => 'X', '3A' => 'O',
         '1B' => 'X', '2B' => nil, '3B' => 'X',
         '1C' => 'O', '2C' => nil, '3C' => nil }, false],
      [{ '1A' => 'O', '2A' => 'X', '3A' => nil,
         '1B' => 'X', '2B' => nil, '3B' => 'X',
         '1C' => 'O', '2C' => 'X', '3C' => nil }, false]
    ].each do |board_all_cells, expected_outcome|
      it "gets #{board_all_cells} and returns #{expected_outcome}" do
        @board.all_cells = board_all_cells
        @board.winner?(@player_o.marker).should == expected_outcome
      end
    end
  end

  describe '#game_over?' do
    it "returns true for win" do
      @board.all_cells = {
        "1A"=> 'O', "2A"=>'O', "3A"=>'O',
        "1B"=> nil, "2B"=>'X', "3B"=> 'X',
        "1C"=> nil, "2C"=>nil, "3C"=> nil
      }
      @board.game_over?.should be_true
    end

    it "returns false for neither win nor tie" do
      @board.all_cells = {
        "1A"=> nil, "2A"=>'O', "3A"=>'O',
        "1B"=> nil, "2B"=>'X', "3B"=> 'X',
        "1C"=> nil, "2C"=>nil, "3C"=> nil
      }
      @board.game_over?.should be_false
    end

    it "returns true for tie" do
      @board.all_cells = {
        "1A"=> 'X', "2A"=>'O', "3A"=>'O',
        "1B"=> 'O', "2B"=>'X', "3B"=> 'X',
        "1C"=> 'X', "2C"=>'O', "3C"=> 'X'
      }
      @board.game_over?.should be_true
    end
  end


    describe '#computer_player_selected?' do
      it 'returns true if one of the players is comptuer' do
        @player_x.player_type = 'human'
        @player_o.player_type = 'computer'
        @game.computer_player_selected?.should be_true
      end

      it 'returns false if none of the players is computer' do
        @player_x.player_type = 'human'
        @player_o.player_type = 'human'
        @game.computer_player_selected?.should be_false
      end
    end

    describe '#who_goes_first' do
      before :each do
        @player_x.turn = 0
        @player_o.turn = 0
      end
      it "sets turn value to one for one of the players" do
        @game.who_goes_first
        expect((@player_x.turn == 1) || (@player_o.turn == 1)).to be_true
      end

      it "sets turn value to one for only one player" do
        @game.who_goes_first
        expect((@player_x.turn == 1) && (@player_o.turn == 1)).to be_false
      end
    end

    context 'validation methods' do
      describe '#validate_type' do
        it 'returns true if type is valid' do
          validation_result = @game.validate_type('human', @player_x)
          expect(validation_result).to be_true
        end

        it 'returns true if type is valid' do
          validation_result = @game.validate_type('computer', @player_x)
          expect(validation_result).to be_true
        end

        it 'returns false if type is not valid' do
          validation_result = @game.validate_type('nothing', @player_x)
          expect(validation_result).to be_false
        end
      end

      describe '#validate_level' do
        it 'returns true if level is valid' do
          validation_result = @game.validate_level('easy')
          expect(validation_result).to be_true
        end

        it 'returns true if level is valid' do
          validation_result = @game.validate_level('hard')
          expect(validation_result).to be_true
        end

        it 'returns false if level is not valid' do
          validation_result = @game.validate_level('nothing')
          expect(validation_result).to be_false
        end
      end
    end

    context 'invalid input methods' do
      before :each do
        @player_x.player_type = 'human'
        @player_o.player_type = 'human'
      end

      describe '#invalid_type' do
        it 'prints invalid message to screen' do
          @game.invalid_type('baddd', @player_x)
          expect(@game.ui.io.last_lines(4)).to include('baddd is not a valid option')
        end

        it 'prints player type message to the screen' do
          @game.invalid_type('baddd', @player_x)
          expect(@game.ui.io.last_lines(4)).to include("For player 'X', enter 'human' or 'computer.")
        end
      end

      describe '#invalid_level' do
        it 'prints invalid message to screen' do
          @game.invalid_level('wrong')
          expect(@game.ui.io.last_lines(4)).to include('wrong is not a valid option')
        end
      end
    end

    context 'setting methods' do
      describe '#set_player_type' do
        it 'assigns type to player object' do
          @player_x.player_type = 'human'
          @game.set_player_type('computer', @player_x)
          expect(@player_x.player_type).to eq('computer')
        end
      end

      describe '#set_first_turn' do
        it 'assigns type to player object' do
          @game.set_first_turn(@player_x)
          expect(@game.ui.io.last_print_call).to include("Player 'X' goes first")
        end

        it 'assigns type to player object' do
          @player_x.turn = 0
          @game.set_first_turn(@player_x)
          expect(@player_x.turn).to eq(1)
        end
      end
    end

    context 'WebGameSetup tests' do

      describe '#set_player_types' do
        before :each do
          @board = MockBoard.new
          @player_x = MockPlayer.new('X')
          @player_o = MockPlayer.new('O')
          @game = WebGame.new(@board, @player_x, @player_o)
        end

        it 'sets player type for player_one' do
          @game.set_player_types('computer', 'human')
          @player_x.player_type.should == 'computer'
        end

        it 'sets player type for player_two' do
          @game.set_player_types('computer', 'human')
          @player_o.player_type.should == 'human'
        end
      end

    end

  end

  context 'gameplay methods' do

    before :each do
      @board    = MockBoard.new
      @player_x = MockPlayer.new('X')
      @player_o = MockPlayer.new('O')
      @game     = CLIGame.new(@board, @player_x, @player_o)
      @player_x.turn = 1
    end

    describe '#play!' do
      it 'exits game when board shows game over' do
        @game.ui.io = MockKernel
        @game.board.all_cells = { "1A"=>'X', "2A"=>'X', "3A"=>'X',
                     "1B"=>'X', "2B"=>'X', "3B"=>'X',
                     "1C"=>'X', "2C"=>'X', "3C"=>'X' }
        @board.set_game_over(true)
        @game.play!.should == 'exited'
      end
    end

    describe '#get_computer_move' do

      it "returns a cell ID when computer is easy" do
        @player_x.player_type = 'computer'
        @game.get_computer_move.should eq('A1')
      end

      it "returns a cell ID when computer is hard" do
        @player_x.player_type = 'computer'
        @game.difficulty_level = 'hard'
        @game.ai = MockAI
        @game.get_computer_move.should eq('A2')
      end
    end

    describe '#computer_move?' do
      before :each do
        @player_o.player_type = 'human'
        @player_x.player_type = 'computer'
      end

      it 'returns true when current player is computer' do
        @player_o.turn = 0
        @player_x.turn = 1
        @game.computer_move?.should be_true
      end

      it 'returns true when current player is computer' do
        @player_o.turn = 1
        @player_x.turn = 0
        @game.computer_move?.should be_false
      end
    end

    describe '#game_status_check' do
      before :each do
        @game.ui.io = MockKernel
      end

      it "returns game over message" do
        @player_x.turn = 1
        @player_o.turn = 0
        @game.game_status_check
        expect(@game.ui.io.last_print_call).to include('GAME OVER! Player')
      end

      it "returns tie game message" do
        @player_x.turn = 0
        @player_o.turn = 1
        @game.game_status_check
        expect(@game.ui.io.last_print_call).to include('tie')
      end
    end

    describe '#verify_move' do
      before :each do
        @player_x = MockPlayer.new('X')
        @player_o = MockPlayer.new('O')
        @game     = CLIGame.new(Board.new(3), @player_x, @player_o)
      end
      it 'adds player Xs marker to the board' do
        @player_x.turn = 1
        @game.verify_move('1A')
        expect(@game.board.all_cells['1A']).to eq('X')
      end

      it 'adds player Os marker to the board' do
        @player_o.turn = 1
        @game.verify_move('1A')
        expect(@game.board.all_cells['1A']).to eq('O')
      end

      it 'returns true if move is valid' do
        @game.board = Board.new(3)
        @game.board.add_marker(@player_x.marker, '1A')
        @game.verify_move('1A').should be_false
      end

      it 'returns true if move is valid' do
        @player_o.turn = 1
        @game.verify_move('1A').should be_true
      end

      it 'prints taken cell message if move is taken' do
        @game.ui.io = MockKernel
        @game.board.add_marker(@player_x.marker, '1A')
        @game.verify_move('1A')
        @game.ui.io.last_print_call.should include("taken")
      end
    end

    describe '#advance_game' do
      it 'prints next move message' do
        @game.ui.io = MockKernel
        @player_x.turn = 1
        @player_o.turn = 0
        @game.advance_game
        expect(@game.ui.io.last_print_call).to include("Player")
      end
    end

    describe '#invalid_move' do
      before :each do
        @game.ui.io = MockKernel
      end

      it "prints taken cell message to screen" do
        @game.invalid_move('3C')
        expect(@game.ui.io.last_print_call).to include('taken')
      end

      it "prints bad cell message to screen" do
        @game.invalid_move('blah!!!')
        expect(@game.ui.io.last_print_call).to include('not a valid cell')
      end
    end

    describe '#current_player' do
      it "returns player with a turn value of 1" do
        @game.current_player.should == @player_x
      end

      it "does not return player with a value of 0" do
        @game.current_player.should_not == @player_o
      end
    end

    describe '#exit_game' do
      it "exits the game" do
        @game.board.all_cells = { "1A"=>'X', "2A"=>'X', "3A"=>'X',
                     "1B"=>'X', "2B"=>'X', "3B"=>'X',
                     "1C"=>'X', "2C"=>'X', "3C"=>'X' }
        @game.ui.io = MockKernel
        @game.exit_game.should == 'exited'
      end
    end

  end
end
require 'spec_helper'

describe 'UI' do

  describe '#next_move_message' do
    it 'returns next move message string' do
      ui = UI.new
      ui.next_move_message('X').should == "Player 'X': Make your move."
    end
  end

end

describe 'CLIUI' do

  context 'Game settings methods' do
    before :each do
      @ui = CLIUI.new
      @ui.io = MockKernel
    end

    describe '#request_player_type' do
      it 'returns player string input from user' do
        @ui.io.set_gets('Human')
        player_type_return = @ui.request_player_type('X')
        expect(player_type_return).to eq('human')
      end
    end

    describe '#request_difficulty_level' do
      it 'returns difficulty string input from user' do
        @ui.io.set_gets('EASY')
        difficulty_level_return = @ui.request_difficulty_level
        expect(difficulty_level_return).to eq('easy')
      end
    end

    describe '#request_board_size' do
      it 'returns board size string input from user' do
        @ui.io.set_gets('3')
        board_size_return = @ui.request_board_size
        expect(board_size_return).to eq('3')
      end
    end

    describe '#request_human_move' do
      it 'gets and standardizes cell ID input' do
        @ui.io.set_gets('a1')
        user_move = @ui.request_human_move
        expect(user_move).to eq('1A')
      end
    end

    describe '#standardize' do
      it "returns cell ID in the correct format" do
        @ui.standardize('1a').should == '1A'
      end

      it "returns cell ID in the correct format" do
        @ui.standardize('a1').should == '1A'
      end
    end
  end

  context 'player move messages' do
    before :each do
      @ui     = CLIUI.new
      @ui.io  = MockKernel
    end

    describe '#first_move_message' do
      it "prints a message with the player's marker" do
        @ui.first_move_message('X')
        MockKernel.last_print_call.should include("Player 'X'")
      end
    end

    describe '#next_move_message' do
      it "prints a message with the player's marker" do
        @ui.next_move_message('X')
        MockKernel.last_print_call.should include("Player 'X'")
      end
    end

    describe '#winning_game_message' do
      it "prints a message with the player's marker" do
        @ui.winning_game_message('X')
        MockKernel.last_print_call.should include("Player 'X'")
      end
    end

    describe '#tie_game_message' do
      it "prints a message indicating the game is a tie" do
        @ui.tie_game_message
        MockKernel.last_print_call.should include("tie")
      end

      it "prints a message that does not include player reference" do
        @ui.tie_game_message
        MockKernel.last_print_call.should_not include("Player 'X'")
      end
    end

    describe '#early_exit_message' do
      it 'prints exiting/goodbye message' do
        @ui.early_exit_message
        MockKernel.last_lines(3).should include('Goodbye!')
      end
    end

  end

  context 'invalid move messages' do
    before :each do
      @ui = CLIUI.new
      @ui.io = MockKernel
      @cell = 'A3'
    end

    describe '#taken_cell_message' do
      it "prints a message with the cell reference" do
        @ui.taken_cell_message(@cell)
        MockKernel.last_print_call.should include("A3")
      end

      it "prints a message indicating cell has been taken" do
        @ui.taken_cell_message(@cell)
        MockKernel.last_print_call.should include("taken")
      end
    end

    describe '#bad_cell_message' do
      it "prints a message with the cell reference" do
        @ui.bad_cell_message(@cell)
        MockKernel.last_print_call.should include("A3")
      end
    end
  end

  context 'game setup messages' do
    before :each do
      @ui = CLIUI.new
      @ui.io = MockKernel
    end

    describe '#difficulty_level_message' do
      it "prints a message prompting user to enter level" do
        @ui.difficulty_level_message
        MockKernel.last_print_call.should include("difficulty level")
      end
    end

    describe '#board_size_message' do
      it "prints a message prompting user to enter level" do
        @ui.board_size_message
        MockKernel.last_print_call.should include("number of rows you want")
      end
    end

    describe '#type_assigned_message' do
      it "prints a message with the selected type" do
        @ui.type_assigned_message('human', 'X')
        MockKernel.last_print_call.should include("Player 'X' is human.")
      end
    end

    describe '#level_assigned_message' do
      it "prints a message with the selected level" do
        @ui.level_assigned_message('easy')
        MockKernel.last_print_call.should include("You selected difficulty level EASY.")
      end
    end

    describe '#board_assigned_message' do
      it "prints a message with the selected board size" do
        @ui.board_assigned_message('3')
        MockKernel.last_print_call.should include("You selected a board with 3 rows.")
      end
    end

    describe '#invalid_input_message' do
      it "prints a with the bad input" do
        @ui.invalid_input_message('baddd')
        MockKernel.last_print_call.should include("baddd is not a valid option.")
      end
    end

  end

end
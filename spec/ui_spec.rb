require 'spec_helper'

describe 'UI' do

  context 'Game settings methods' do
    before :each do
      @board    = MockBoard.new
      @player_x = MockPlayer.new('X')
      @player_o = MockPlayer.new('O')
      @ui       = CLIUI.new(@board)
      @ui.io    = MockKernel
    end

    describe '#request_player_type' do
      it 'returns string input from user' do
        @ui.io.set_gets('Human')
        player_type_return = @ui.request_player_type('X')
        expect(player_type_return).to eq('human')
      end
    end

    describe '#request_difficulty_level' do
      it 'returns string input from user' do
        @ui.io.set_gets('EASY')
        difficulty_level_return = @ui.request_difficulty_level
        expect(difficulty_level_return).to eq('easy')
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
      board   = MockBoard.new
      @ui     = CLIUI.new(board)
      @ui.io  = MockKernel
      @player = MockPlayer.new('X')
    end

    describe '#first_move_message' do
      it "prints a message with the player's marker" do
        @ui.first_move_message(@player)
        MockKernel.last_print_call.should include("Player 'X'")
      end
    end

    describe '#next_move_message' do
      it "prints a message with the player's marker" do
        @ui.next_move_message(@player)
        MockKernel.last_print_call.should include("Player 'X'")
      end
    end

    describe '#winning_game_message' do
      it "prints a message with the player's marker" do
        @ui.winning_game_message(@player)
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
  end

  context 'invalid move messages' do
    before :each do
      board  = MockBoard.new
      @ui    = CLIUI.new(board)
      @ui.io = MockKernel
      @cell  = 'A3'
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
      board  = MockBoard.new
      @ui    = CLIUI.new(board)
      @ui.io = MockKernel
    end

    describe '#difficulty_level_message' do
      it "prints a message prompting user to enter level" do
        @ui.difficulty_level_message
        MockKernel.last_print_call.should include("difficulty level")
      end
    end

    describe '#level_assigned_message' do
      it "prints a message with the selected level" do
        level = 'easy'
        @ui.level_assigned_message(level)
        MockKernel.last_print_call.should include("EASY")
      end
    end

    describe '#invalid_input_message' do
      it "prints a with the bad input" do
        input = 'baddd'
        @ui.invalid_input_message(input)
        MockKernel.last_print_call.should include("baddd")
      end
    end

  end

  context 'displaying the board grid' do
    before :each do
       board  = MockBoard.new
       board.all_cells = {"1A"=>nil, "2A"=>'X', "3A"=>nil,
                          "1B"=>'O', "2B"=>'O', "3B"=>nil,
                          "1C"=>nil, "2C"=>nil, "3C"=>nil}
       @ui    = CLIUI.new(board)
       @ui.io = MockKernel
     end

    describe '#print_board_numbers' do
      it "prints numbers for each row on the board" do
        @ui.print_board_numbers
        @ui.io.last_lines(9).should include("1", "2", "3")
      end
    end

    describe '#print_divider' do
      it "prints divider below each row on the board" do
        @ui.print_divider
        @ui.io.last_lines(4).should include("------------------")
      end
    end

    describe '#show_row' do
      it "prints row with a marker present" do
        cells = ['1A', '2A', '3A']
        @ui.show_row('A', cells)
        @ui.io.last_lines(9).should include("  |     |  X  |  ")
      end

      it "prints row blank row" do
        cells = ['1B', '2B', '3B']
        @ui.show_row('A', cells)
        @ui.io.last_lines(9).should include("  |  O  |  O  |  ")
      end

      it "prints row with two markers present" do
        cells = ['1C', '2C', '3C']
        @ui.show_row('A', cells)
        @ui.io.last_lines(9).should include("  |     |     |  ")
      end
    end

    describe '#display_board' do
      it "calls print_board_numbers twice" do
        @ui.display_board
        @ui.io.last_lines(35).should include("1", "2", "3")
      end

      it "calls print_board_rows once" do
        @ui.display_board
        @ui.io.last_lines(35).should include("A", "B", "C")
      end
    end

    describe '#early_exit_message' do
      it "prints exit message to screen" do
        @ui.early_exit_message
        @ui.io.last_lines(4).should include("Exiting Tic-Tac-Toe")
      end
    end

  end

  context 'WebUI print board methods' do
    before :each do
       board  = MockBoard.new
       board.all_cells = {"1A"=>nil, "2A"=>'X', "3A"=>nil,
                          "1B"=>nil, "2B"=>nil, "3B"=>nil,
                          "1C"=>nil, "2C"=>nil, "3C"=>nil}
       @ui    = WebUI.new(board)
     end

    describe '#print_active_board' do
      it 'prints cells with value attributes' do
        @ui.print_active_board.should include("<button name='move' value='2A'> X <span class='cell'>.</span></button>")
      end
    end

    describe '#print_inactive_board' do
      it 'prints cells without value attributes' do
        @ui.print_inactive_board.should include("<button> X <span class='cell'>.</span></button>")
      end
    end

  end

end
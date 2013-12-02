require 'spec_helper'

describe 'UI' do

  context 'player move messages' do
    before :each do
      board   = double('board')
      @ui     = UI.new(board)
      @player = double('player', :marker => 'X' )
    end

    describe '#first_move_message' do
      it "prints a message with the player's marker" do
        printed = capture_stdout { @ui.first_move_message(@player) }
        printed.should include("Player 'X'")
      end
    end

    describe '#next_move_message' do
      it "prints a message with the player's marker" do
        printed = capture_stdout { @ui.next_move_message(@player) }
        printed.should include("Player 'X'")
      end
    end

    describe '#winning_game_message' do
      it "prints a message with the player's marker" do
        printed = capture_stdout { @ui.winning_game_message(@player) }
        printed.should include("Player 'X'")
      end
    end

    describe '#tie_game_message' do
      it "prints a message indicating the game is a tie" do
        printed = capture_stdout { @ui.tie_game_message }
        printed.should include("tie")
      end

      it "prints a message that does not include player reference" do
        printed = capture_stdout { @ui.tie_game_message }
        printed.should_not include("Player 'X'")
      end
    end
  end

  context 'invalid move messages' do
    before :each do
      board = double('board')
      @ui   = UI.new(board)
      @cell = 'A3'
    end

    describe '#taken_cell_message' do
      it "prints a message with the cell reference" do
        printed = capture_stdout { @ui.taken_cell_message(@cell) }
        printed.should include("A3")
      end

      it "prints a message indicating cell has been taken" do
        printed = capture_stdout { @ui.taken_cell_message(@cell) }
        printed.should include("taken")
      end
    end

    describe '#bad_cell_message' do
      it "prints a message with the cell reference" do
        printed = capture_stdout { @ui.bad_cell_message(@cell) }
        printed.should include("A3")
      end
    end
  end

  context 'game setup messages' do
    before :each do
      board = double('board')
      @ui   = UI.new(board)
    end

    describe '#difficulty_level_message' do
      it "prints a message prompting user to enter level" do
        printed = capture_stdout { @ui.difficulty_level_message }
        printed.should include("difficulty level")
      end
    end

    describe '#level_assigned_message' do
      it "prints a message with the selected level" do
        level = 'easy'
        printed = capture_stdout { @ui.level_assigned_message(level) }
        printed.should include("EASY")
      end
    end

    describe '#invalid_input_message' do
      it "prints a with the bad input" do
        input = 'baddd'
        printed = capture_stdout { @ui.invalid_input_message(input) }
        printed.should include("baddd")
      end
    end

  end

  context 'displaying the board grid' do
    before :each do
       board = double('board', :num_of_rows => 3, :all_cells =>
        {"1A"=>nil, "2A"=>'X', "3A"=>nil,
         "1B"=>'O', "2B"=>'O', "3B"=>nil,
         "1C"=>nil, "2C"=>nil, "3C"=>nil},
         :winning_rows => [[],[],[]] )
       @ui = UI.new(board)
     end

    describe '#print_board_numbers' do
      it "prints numbers for each row on the board" do
        printed = capture_stdout { @ui.print_board_numbers }
        printed.should include("1", "2", "3")
      end
    end

    describe '#print_divider' do
      it "prints divider below each row on the board" do
        printed = capture_stdout { @ui.print_divider }
        printed.should include("------------------")
      end
    end

    describe '#show_row' do
      it "prints row with a marker present" do
        cells = ['1A', '2A', '3A']
        printed = capture_stdout { @ui.show_row('A', cells) }
        printed.should include("  |     |  X  |  ")
      end

      it "prints row blank row" do
        cells = ['1B', '2B', '3B']
        printed = capture_stdout { @ui.show_row('A', cells) }
        printed.should include("  |  O  |  O  |  ")
      end

      it "prints row with two markers present" do
        cells = ['1C', '2C', '3C']
        printed = capture_stdout { @ui.show_row('A', cells) }
        printed.should include("  |     |     |  ")
      end
    end

    describe '#display_board' do
      it "calls print_board_numbers twice" do
        expect(@ui).to receive(:print_board_numbers).twice
        @ui.display_board
      end

      it "calls print_board_rows once" do
        expect(@ui).to receive(:print_board_rows).once
        @ui.display_board
      end
    end

  end

end
require 'spec_helper'

describe 'UI' do

  class MockKernel
    @@input = nil
    @@lines = []
    def self.print(string)
      @@input = string
      @@lines.push(@@input)
    end

    def self.last_print_call
      @@input
    end

    def self.last_lines(num)
      @@lines[-num..-1].join('')
    end
  end

  class MockBoard
    attr_accessor :num_of_rows, :all_cells, :winning_rows
    def initialize
      @num_of_rows  = 3
      @all_cells    = {},
      @winning_rows = [[],[],[]]
    end
  end

  class MockPlayer
    attr_accessor :marker
    def initialize
      @marker = 'X'
    end
  end

  context 'player move messages' do
    before :each do
      board   = MockBoard.new
      @ui     = UI.new(board)
      @ui.io  = MockKernel
      @player = MockPlayer.new
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
      @ui    = UI.new(board)
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
      @ui    = UI.new(board)
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
       @ui    = UI.new(board)
       @ui.io = MockKernel
     end

    describe '#print_board_numbers' do
      it "prints numbers for each row on the board" do
        @ui.print_board_numbers
        MockKernel.last_lines(9).should include("1", "2", "3")
      end
    end

    describe '#print_divider' do
      it "prints divider below each row on the board" do
        @ui.print_divider
        MockKernel.last_lines(4).should include("------------------")
      end
    end

    describe '#show_row' do
      it "prints row with a marker present" do
        cells = ['1A', '2A', '3A']
        @ui.show_row('A', cells)
        MockKernel.last_lines(9).should include("  |     |  X  |  ")
      end

      it "prints row blank row" do
        cells = ['1B', '2B', '3B']
        @ui.show_row('A', cells)
        MockKernel.last_lines(9).should include("  |  O  |  O  |  ")
      end

      it "prints row with two markers present" do
        cells = ['1C', '2C', '3C']
        @ui.show_row('A', cells)
        MockKernel.last_lines(9).should include("  |     |     |  ")
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
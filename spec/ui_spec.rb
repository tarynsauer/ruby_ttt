require 'spec_helper'

describe 'UI' do

  context 'player move messages' do

  before :each do
    board = double('board')
    @ui    = UI.new(board)
    @player = double('player', :marker => 'X' )
  end

    describe '#first_move_message' do
      it "Prints a message with the player's marker" do
        printed = capture_stdout { @ui.first_move_message(@player) }
        printed.should include("Player 'X'")
      end
    end

    describe '#next_move_message' do
      it "Prints a message with the player's marker" do
        printed = capture_stdout { @ui.next_move_message(@player) }
        printed.should include("Player 'X'")
      end
    end

    describe '#winning_game_message' do
      it "Prints a message with the player's marker" do
        printed = capture_stdout { @ui.winning_game_message(@player) }
        printed.should include("Player 'X'")
      end
    end

    describe '#tie_game_message' do
      it "Prints a message indicating the game is a tie" do
        printed = capture_stdout { @ui.tie_game_message }
        printed.should include("tie")
      end

      it "Prints a message that does not include player reference" do
        printed = capture_stdout { @ui.tie_game_message }
        printed.should_not include("Player 'X'")
      end
    end

  end

  context 'Invalid move messages' do

    before :each do
      board = double('board')
      @ui    = UI.new(board)
      @cell = 'A3'
    end

    describe '#taken_cell_message' do
      it "Prints a message with the cell reference" do
        printed = capture_stdout { @ui.taken_cell_message(@cell) }
        printed.should include("A3")
      end

      it "Prints a message indicating cell has been taken" do
        printed = capture_stdout { @ui.taken_cell_message(@cell) }
        printed.should include("taken")
      end
    end

    describe '#bad_cell_message' do
      it "Prints a message with the cell reference" do
        printed = capture_stdout { @ui.bad_cell_message(@cell) }
        printed.should include("A3")
      end
    end
  end

  context 'Game setup messages' do

    before :each do
      board = double('board')
      @ui    = UI.new(board)
      @cell = 'A3'
    end


  end

end
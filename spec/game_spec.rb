require 'spec_helper'

describe 'Game' do

  before :each do
    @board    = MockBoard.new
    @ui = CLIUI.new(@board)
    @player_x = MockPlayer.new('X')
    @player_o = MockPlayer.new('O')
    @game     = CLIGame.new(@board, @ui, @player_x, @player_o, 'easy')
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
      @game = CLIGame.new(@board, @ui, @player_x, @player_o, 'hard')
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
      @game.ui = CLIUI.new(MockBoard.new)
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
      @game     = CLIGame.new(Board.new(3), @ui, @player_x, @player_o, 'easy')
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
      @game.ui = CLIUI.new(MockBoard.new)
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
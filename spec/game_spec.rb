require 'spec_helper'

describe 'Game' do

  before :each do
    @player_x = MockPlayer.new('X')
    @player_o = MockPlayer.new('O')
    settings = { :board => MockBoard.new,
                 :player_one => @player_x,
                 :player_two => @player_o,
                 :player_first_move => @player_x}
    @game = CLIGame.new(settings)
    @game.ui.io = MockKernel
  end

  context 'gameplay methods' do

    before :each do
      @player_x = HumanPlayer.new('X')
      settings = { :board => MockBoard.new,
                 :player_one => @player_x,
                 :player_two => AIPlayer.new('O'),
                 :player_first_move => @player_x}
      @game = CLIGame.new(settings)
      @game.ui.io = MockKernel
    end

    # describe '#play!' do
    #   it 'exits game when board shows game over' do
    #     @game.ui.io = MockKernel
    #     @game.board.all_cells = { "1A"=>'X', "2A"=>'X', "3A"=>'X',
    #                  "1B"=>'X', "2B"=>'X', "3B"=>'X',
    #                  "1C"=>'X', "2C"=>'X', "3C"=>'X' }
    #     @board.set_game_over(true)
    #     @game.play!.should == 'exited'
    #   end
    # end
    describe '#get_next_move' do
      it 'calls #request_human_move when current_player is a HumanPlayer' do
        @game.ui.io.set_gets('1B')
        @game.get_next_move.should == '1B'
      end
    end

  end

  describe '#game_status_check' do
    before :each do
      @player_x = MockPlayer.new('X')
      @player_o = MockPlayer.new('O')
      settings = { :board => MockBoard.new,
                   :player_one => @player_x,
                   :player_two => @player_o,
                   :player_first_move => @player_x}
      @game = CLIGame.new(settings)
      @game.ui.io = MockKernel
    end

    it "returns game over message" do
      @game.board.all_cells = { "1A"=> nil, "2A"=>'O', "3A"=>'O',
                                "1B"=> 'X', "2B"=>'X', "3B"=> 'X',
                                "1C"=> nil, "2C"=>nil, "3C"=> nil }
      @game.game_status_check('X')
      expect(@game.ui.io.last_print_call).to include("GAME OVER! Player 'X' wins!")
    end

    it "returns tie game message" do
      @game.board.all_cells = { "1A"=> 'O', "2A"=>'X', "3A"=>'O',
                                "1B"=> 'X', "2B"=>'X', "3B"=> 'X',
                                "1C"=> 'O', "2C"=>'O', "3C"=> 'X' }
      @game.game_status_check('O')
      expect(@game.ui.io.last_print_call).to include('tie')
    end
  end

  describe '#verify_move' do
    before :each do
      @player_x = HumanPlayer.new('X')
      @player_o = HumanPlayer.new('O')
      settings = { :board => MockBoard.new,
                   :player_one => @player_x,
                   :player_two => @player_o,
                   :player_first_move => @player_x}
      @game = CLIGame.new(settings)
    end
    it 'adds player Xs marker to the board' do
      @game.verify_move('1A')
      @game.board.all_cells['1A'].should == 'X'
    end

    it 'adds player Os marker to the board' do
      @game.verify_move('1A')
      @game.verify_move('1B')
      @game.board.all_cells['1B'].should == 'O'
    end

    it 'returns false if move is invalid' do
      @game.board.all_cells = { "1A"=> 'X', "2A"=>'O', "3A"=>'O',
                                "1B"=> nil, "2B"=>'X', "3B"=> 'X',
                                "1C"=> nil, "2C"=>nil, "3C"=> nil }
      @game.verify_move('1A').should be_false
    end

    it 'returns true if move is valid' do
      @game.verify_move('1A').should be_true
    end

  end

  describe '#advance_game' do
    it 'prints next move message' do
      @game.ui.io = MockKernel
      @game.advance_game
      expect(@game.ui.io.last_print_call).to include("Player 'X': Enter open cell ID")
    end
  end

  describe '#invalid_move' do
    before :each do
      @player_x = MockPlayer.new('X')
      @player_o = MockPlayer.new('O')
      settings = { :board => MockBoard.new,
               :player_one => @player_x,
               :player_two => @player_o,
               :player_first_move => @player_x}
      @game = CLIGame.new(settings)
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

  describe '#total_markers' do
    before :each do
      @player_x = MockPlayer.new(MARKER_X)
      @player_o = MockPlayer.new(MARKER_O)
      settings = { :board => MockBoard.new,
               :player_one => @player_x,
               :player_two => @player_o,
               :player_first_move => @player_x}
      @game = CLIGame.new(settings)
      @game.ui.io = MockKernel
      @game.board.all_cells = { "1A"=>'X', "2A"=>'X', "3A"=>'O',
                                "1B"=>'O', "2B"=>'O', "3B"=>nil,
                                "1C"=>nil, "2C"=>nil, "3C"=>nil }
    end

    it 'returns the total X markers on the board' do
      @game.total_markers(MARKER_X).should == 2
    end

    it 'returns the total O marker on the board' do
      @game.total_markers(MARKER_O).should == 3
    end
  end

  describe '#current_player' do

    before :each do
      @player_x = MockPlayer.new(MARKER_X)
      @player_o = MockPlayer.new(MARKER_O)
      settings = { :board => MockBoard.new,
                   :player_one => @player_x,
                   :player_two => @player_o,
                   :player_first_move => @player_x}
      @game = CLIGame.new(settings)
      @game.ui.io = MockKernel
    end

    it "returns player X when X's turn" do
      @game.board.all_cells = { "1A"=>'X', "2A"=>'X', "3A"=>'O',
                                "1B"=>'O', "2B"=>'O', "3B"=>nil,
                                "1C"=>nil, "2C"=>nil, "3C"=>nil }
      @game.current_player.should == @player_x
    end

    it "returns player O when O's turn" do
      @game.board.all_cells = { "1A"=>'X', "2A"=>'X', "3A"=>'O',
                                "1B"=>'X', "2B"=>'O', "3B"=>nil,
                                "1C"=>nil, "2C"=>nil, "3C"=>nil }
      @game.current_player.should == @player_o
    end

    it "returns player_first_move when equal markers on board" do
      @game.board.all_cells = { "1A"=>'X', "2A"=>'X', "3A"=>'O',
                                "1B"=>'X', "2B"=>'O', "3B"=>nil,
                                "1C"=>'O', "2C"=>nil, "3C"=>nil }
      @game.current_player.should == @player_x
    end
  end

  describe '#exit_game' do
    it "exits the game" do
      @game.board = CLIBoard.new(3)
      @game.ui.io = MockKernel
      @game.exit_game.should == 'exited'
    end
  end
end
require 'spec_helper'

describe 'RubyTictactoe::Game' do

  before :each do
    @player_x = MockPlayer.new('X')
    @player_o = MockPlayer.new('O')
    settings = { :board => MockBoard.new,
                 :player_one => @player_x,
                 :player_two => @player_o,
                 :player_first_move => @player_x}
    @game = RubyTictactoe::CLIGame.new(settings)
    @game.ui.io = MockKernel
  end

  context 'gameplay methods' do

    before :each do
      @player_x = RubyTictactoe::ComputerPlayer.new('X')
      @player_o = RubyTictactoe::ComputerPlayer.new('O')
      settings = { :board => RubyTictactoe::CLIBoard.new(3),
                 :player_one => @player_x,
                 :player_two => @player_o,
                 :player_first_move => @player_x}
      @game = RubyTictactoe::CLIGame.new(settings)
      @game.ui.io = MockKernel
      @player_x.opponent = @player_o
      @player_o.opponent = @player_x
    end

    describe '#play!' do
      it 'exits game when board shows game over' do
        @game.board.all_cells = { "1A"=>'X', "2A"=>'X', "3A"=>'X',
                     "1B"=>'X', "2B"=>'X', "3B"=>'X',
                     "1C"=>'X', "2C"=>'X', "3C"=>'X' }
        @game.play!.should == 'exited'
      end

      it 'plays through game until game over' do
        @game.play!
        @game.ui.io.last_print_call.should include('GAME OVER!')
      end
    end

    describe '#start_game!' do

      it 'plays through game until game over' do
        @game.start_game!
        @game.ui.io.last_print_call.should include('GAME OVER!')
      end
    end

    describe '#get_next_move' do
      it 'calls #request_human_move when current_player is a HumanPlayer' do
        @game.ui.io.set_gets('1B')
        @game.get_next_move
        @game.ui.io.last_print_call.should include("Player 'O': Enter open cell ID")
      end

      it 'calls #invalid_move when human enters bad value' do
        @player_x = RubyTictactoe::HumanPlayer.new('X')
        @player_o = MockPlayer.new('O')
        settings = { :board => RubyTictactoe::CLIBoard.new(3),
                     :player_one => @player_x,
                     :player_two => @player_o,
                     :player_first_move => @player_x }
        @game = RubyTictactoe::CLIGame.new(settings)
        @game.ui.io = MockKernel
        @player_x.opponent = @player_o
        @player_o.opponent = @player_x
        @game.ui.io.set_gets('bad_value')
        @game.get_next_move
        @game.ui.io.last_lines(2).should include("not a valid cell ID!")
      end

      it 'calls #make_move when current_player is a ComputerPlayer' do
        @player_x.add_marker(@game.board, '1A')
        @game.get_next_move
        @game.ui.io.last_print_call.should include("Player 'X': Enter open cell ID")
      end
    end

  end

  describe '#game_status_check' do
    before :each do
      @player_x = MockPlayer.new('X')
      @player_o = MockPlayer.new('O')
      settings = { :board => RubyTictactoe::Board.new(3),
                   :player_one => @player_x,
                   :player_two => @player_o,
                   :player_first_move => @player_x}
      @game = RubyTictactoe::CLIGame.new(settings)
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
      @player_x = RubyTictactoe::HumanPlayer.new('X')
      @player_o = RubyTictactoe::HumanPlayer.new('O')
      settings = { :board => RubyTictactoe::Board.new(3),
                   :player_one => @player_x,
                   :player_two => @player_o,
                   :player_first_move => @player_x}
      @game = RubyTictactoe::CLIGame.new(settings)
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
      @player_x.opponent = @player_o
      @player_o.opponent = @player_x
      @game.ui.io = MockKernel
      @game.board = RubyTictactoe::Board.new(3)
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
      @game = RubyTictactoe::CLIGame.new(settings)
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
      @player_x = MockPlayer.new(RubyTictactoe::TictactoeConstants::MARKER_X)
      @player_o = MockPlayer.new(RubyTictactoe::TictactoeConstants::MARKER_O)
      settings = { :board => MockBoard.new,
               :player_one => @player_x,
               :player_two => @player_o,
               :player_first_move => @player_x}
      @game = RubyTictactoe::CLIGame.new(settings)
      @game.ui.io = MockKernel
      @game.board.all_cells = { "1A"=>'X', "2A"=>'X', "3A"=>'O',
                                "1B"=>'O', "2B"=>'O', "3B"=>nil,
                                "1C"=>nil, "2C"=>nil, "3C"=>nil }
    end

    it 'returns the total X markers on the board' do
      @game.total_markers(RubyTictactoe::TictactoeConstants::MARKER_X).should == 2
    end

    it 'returns the total O marker on the board' do
      @game.total_markers(RubyTictactoe::TictactoeConstants::MARKER_O).should == 3
    end
  end

  describe '#current_player' do

    before :each do
      @player_x = MockPlayer.new(RubyTictactoe::TictactoeConstants::MARKER_X)
      @player_o = MockPlayer.new(RubyTictactoe::TictactoeConstants::MARKER_O)
      settings = { :board => MockBoard.new,
                   :player_one => @player_x,
                   :player_two => @player_o,
                   :player_first_move => @player_x}
      @game = RubyTictactoe::CLIGame.new(settings)
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
      @game.board = RubyTictactoe::CLIBoard.new(3)
      @game.ui.io = MockKernel
      @game.exit_game.should == 'exited'
    end
  end
end

describe 'WebGame' do

  before :each do
    @player_x = RubyTictactoe::HumanPlayer.new('X')
    @player_o = RubyTictactoe::HumanPlayer.new('O')
    @player_x.opponent = @player_o
    @player_o.opponent = @player_x
    settings = { :board => RubyTictactoe::WebBoard.new(3),
                 :player_one => @player_x,
                 :player_two => @player_o,
                 :player_first_move => @player_x}
    @game = RubyTictactoe::WebGame.new(settings)
  end

  describe '#initialize' do
    it 'has the correct UI object' do
      @game.ui.is_a?(RubyTictactoe::UI)
    end
  end

  describe '#get_message' do
    it 'returns first move message when board is empty' do
      @game.board.all_cells = { '1A' => nil, '2A' => nil, '3A' => nil,
                                '1B' => nil,'2B' => nil, '3B' => nil,
                                '1C' => nil, '2C' => nil, '3C' => nil }
      @game.get_message(@player_x).should include('goes first')
    end

    it 'returns tie game message when board shows tie game' do
      @game.board.all_cells = { '1A' => 'X', '2A' => 'X', '3A' => 'O',
                                '1B' => 'O','2B' => 'O', '3B' => 'X',
                                '1C' => 'X', '2C' => 'O', '3C' => 'X' }
      @game.get_message(@player_x).should == "GAME OVER! It's a tie!"
    end

    it 'returns player X wins message when board shows X is winner' do
      @game.board.all_cells = { '1A' => 'X', '2A' => 'X', '3A' => 'X',
                                '1B' => 'O','2B' => 'O', '3B' => nil,
                                '1C' => nil, '2C' => nil, '3C' => nil }
      @game.get_message(@player_x).should == "GAME OVER! Player 'X' wins!"
    end

    it 'returns player O wins message when board shows O is winner' do
      @game.board.all_cells = { '1A' => 'O', '2A' => 'O', '3A' => 'O',
                                '1B' => 'X','2B' => 'X', '3B' => nil,
                                '1C' => nil, '2C' => nil, '3C' => nil }
      @game.get_message(@player_x).should == "GAME OVER! Player 'O' wins!"
    end

    it 'returns player X move message when it is Xs turn' do
      @game.board.all_cells = { '1A' => 'O', '2A' => 'X', '3A' => 'O',
                                '1B' => nil,'2B' => nil, '3B' => nil,
                                '1C' => nil, '2C' => nil, '3C' => nil }
      @game.get_message(@player_x).should == "Player 'X': Make your move."
    end

    it 'returns player O move message when it is Os turn' do
      @game.board.all_cells = { '1A' => nil, '2A' => nil, '3A' => nil,
                                '1B' => 'X','2B' => 'O', '3B' => 'X',
                                '1C' => nil, '2C' => nil, '3C' => nil }
      @game.get_message(@player_x).should == "Player 'O': Make your move."
    end
  end

  describe '#get_first_move_player' do
    it 'returns a player object' do
      player = @game.get_first_move_player('human', 'human')
      player.is_a?(RubyTictactoe::HumanPlayer)
    end
  end

  describe '#computer_player?' do
    it 'returns false if there is no computer player' do
      @game.computer_player?('human', 'human').should be_false
    end

    it 'returns true if there is a computer player' do
      @game.computer_player?('computer', 'human').should be_true
    end
  end

end
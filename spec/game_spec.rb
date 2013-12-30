require 'spec_helper'

describe 'RubyTictactoe::Game' do

  before :each do
    @player_x = MockPlayer.new('X')
    @player_o = MockPlayer.new('O')
    @player_o.opponent = @player_x
    @player_x.opponent = @player_o
    settings = { :board => MockBoard.new,
                 :player_one => @player_x,
                 :player_two => @player_o,
                 :player_first_move => @player_x}
    @game = RubyTictactoe::Game.new(settings)
  end

  describe '#game_status_check' do
    it "returns game over message" do
      @game.board.all_cells = { "1A"=> nil, "2A"=>'O', "3A"=>'O',
                                "1B"=> 'X', "2B"=>'X', "3B"=> 'X',
                                "1C"=> nil, "2C"=>nil, "3C"=> nil }

      expect(@game.game_status_check('O')) == "GAME OVER! Player 'X' wins!"
    end

    it "returns tie game message" do
      @game.board.all_cells = { "1A"=> 'O', "2A"=>'X', "3A"=>'O',
                                "1B"=> 'X', "2B"=>'X', "3B"=> 'X',
                                "1C"=> 'O', "2C"=>'O', "3C"=> 'X' }
      expect(@game.game_status_check('O')).to include('tie')
    end

    it "returns no message" do
      @game.board.all_cells = { "1A"=> nil, "2A"=>'O', "3A"=>'O',
                                "1B"=> 'X', "2B"=>nil, "3B"=> 'X',
                                "1C"=> nil, "2C"=>nil, "3C"=> nil }

      expect(@game.game_status_check('X')) == ""
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
      @game = RubyTictactoe::Game.new(settings)
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
    it 'returns next move message' do
      expect(@game.advance_game).to include("Player 'X': Make your move")
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
      @game = RubyTictactoe::Game.new(settings)
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
      @game = RubyTictactoe::Game.new(settings)
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

end
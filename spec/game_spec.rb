require 'spec_helper'

describe 'Game' do

  before :each do
    @board    = MockBoard.new
    @player_x = MockPlayer.new('X')
    @player_o = MockPlayer.new('O')
    @game     = Game.new(@board, @player_x, @player_o, 'easy')
    @player_x.turn = 1
  end

  describe '#get_next_move' do
    it "returns player input when current player is human" do
      @player_x.player_type = 'human'
      @game.ui.io = MockKernel
      @game.ui.io.set_gets('a1')
      @game.get_next_move.should == '1A'
    end

    it "returns a cell ID when computer is easy" do
      @player_x.player_type = 'computer'
      @game.get_next_move.should eq('A1')
    end

    it "returns a cell ID when computer is hard" do
      @player_x.player_type = 'computer'
      @game = Game.new(@board, @player_x, @player_o, 'hard')
      @game.ai = MockAI
      @game.get_next_move.should eq('A2')
    end
  end

  describe '#game_status_check' do
    before :each do
      @game.ui.io = MockKernel
    end

    it "returns player with a turn value of 1" do
      @player_x.turn = 1
      @player_o.turn = 0
      @game.game_status_check
      expect(@game.ui.io.last_print_call).to include('GAME OVER! Player')
    end

    it "does not return player with a value of 0" do
      @player_x.turn = 0
      @player_o.turn = 1
      @game.game_status_check
      expect(@game.ui.io.last_print_call).to include('tie')
    end
  end

  describe '#advance_game' do
    before :each do
      @player_x = MockPlayer.new('X')
      @player_o = MockPlayer.new('O')
      @game     = Game.new(Board.new(3), @player_x, @player_o, 'easy')
    end
    it 'adds player Xs marker to the board' do
      @game.advance_game('1A', @player_x)
      expect(@game.board.all_cells['1A']).to eq('X')
    end

    it 'adds player Os marker to the board' do
      @game.advance_game('1A', @player_o)
      expect(@game.board.all_cells['1A']).to eq('O')
    end

    it 'prints next move message' do
      @game.ui.io = MockKernel
      @player_x.turn = 1
      @player_o.turn = 0
      @game.advance_game('1A', @player_x)
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

end
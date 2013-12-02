require 'spec_helper'

describe 'Player' do

  before :each do
    @board    = Board.new(3)
    @game     = TestGame.new(@board)
    @player_x = @game.player_one
    @player_o = @game.player_two
  end

  describe '#add_marker' do
    it "adds player's marker to the board" do
      @player_x.add_marker(@board, '1A')
      @board.all_cells['1A'].should == 'X'
    end

    it "adds player's marker to the board" do
      @player_o.add_marker(@board, '1B')
      @board.all_cells['1B'].should == 'O'
    end
  end

  describe '#winner? returns correct boolean value' do
    [
      [{ '1A' => nil, '2A' => 'X', '3A' => 'O',
         '1B' => 'X', '2B' => 'O', '3B' => 'X',
         '1C' => 'O', '2C' => nil, '3C' => nil }, true],
      [{ '1A' => 'O', '2A' => 'X', '3A' => nil,
         '1B' => 'O', '2B' => nil, '3B' => 'X',
         '1C' => 'O', '2C' => 'X', '3C' => nil }, true],
      [{ '1A' => 'O', '2A' => 'O', '3A' => 'O',
         '1B' => nil, '2B' => 'X', '3B' => 'X',
         '1C' => nil, '2C' => nil, '3C' => nil }, true],
      [{ '1A' => 'O', '2A' => 'X', '3A' => 'O',
         '1B' => 'O', '2B' => 'O', '3B' => 'X',
         '1C' => 'X', '2C' => 'X', '3C' => 'O' }, true],
      [{ '1A' => nil, '2A' => 'X', '3A' => 'O',
         '1B' => 'X', '2B' => nil, '3B' => 'X',
         '1C' => 'O', '2C' => nil, '3C' => nil }, false],
      [{ '1A' => 'O', '2A' => 'X', '3A' => nil,
         '1B' => 'X', '2B' => nil, '3B' => 'X',
         '1C' => 'O', '2C' => 'X', '3C' => nil }, false]
    ].each do |board_all_cells, expected_outcome|
      it "gets #{board_all_cells} and returns #{expected_outcome}" do
        @board.all_cells = board_all_cells
        @player_o.winner?(@board).should == expected_outcome
      end
    end
  end

  describe '#loser? returns correct boolean value' do
    [
      [{ '1A' => nil, '2A' => 'X', '3A' => 'O',
         '1B' => 'X', '2B' => 'O', '3B' => 'X',
         '1C' => 'O', '2C' => nil, '3C' => nil }, false],
      [{ '1A' => 'O', '2A' => 'X', '3A' => nil,
         '1B' => 'O', '2B' => nil, '3B' => 'X',
         '1C' => 'O', '2C' => 'X', '3C' => nil }, false],
      [{ '1A' => 'O', '2A' => 'O', '3A' => 'O',
         '1B' => nil, '2B' => 'X', '3B' => 'X',
         '1C' => nil, '2C' => nil, '3C' => nil }, false],
      [{ '1A' => 'O', '2A' => 'X', '3A' => 'O',
         '1B' => 'O', '2B' => 'O', '3B' => 'X',
         '1C' => 'X', '2C' => 'X', '3C' => nil }, false],
      [{ '1A' => nil, '2A' => 'X', '3A' => 'O',
         '1B' => nil, '2B' => 'X', '3B' => nil,
         '1C' => 'O', '2C' => 'X', '3C' => nil }, true],
      [{ '1A' => 'O', '2A' => 'X', '3A' => 'O',
         '1B' => 'X', '2B' => 'X', '3B' => 'X',
         '1C' => 'O', '2C' => 'X', '3C' => nil }, true]
    ].each do |board_all_cells, expected_outcome|
      it "gets #{board_all_cells} and returns #{expected_outcome}" do
        @board.all_cells = board_all_cells
        @player_o.loser?(@board).should == expected_outcome
      end
    end
  end

  describe '#game_over?' do
    before :each do
      @board    = Board.new(3)
      @game     = TestGame.new(@board)
      @player_x = @game.player_one
      @player_o = @game.player_two

    end

    it "returns true for win" do
      @board.all_cells = {
        "1A"=> 'O', "2A"=>'O', "3A"=>'O',
        "1B"=> nil, "2B"=>'X', "3B"=> 'X',
        "1C"=> nil, "2C"=>nil, "3C"=> nil
      }
      @player_o.game_over?(@board).should == true
    end

    it "returns false for neither win nor tie" do
      @board.all_cells = {
        "1A"=> nil, "2A"=>'O', "3A"=>'O',
        "1B"=> nil, "2B"=>'X', "3B"=> 'X',
        "1C"=> nil, "2C"=>nil, "3C"=> nil
      }
      @player_o.game_over?(@board).should == false
    end

    it "returns true for tie" do
      @board.all_cells = {
        "1A"=> 'X', "2A"=>'O', "3A"=>'O',
        "1B"=> 'O', "2B"=>'X', "3B"=> 'X',
        "1C"=> 'X', "2C"=>'O', "3C"=> 'X'
      }
      @player_o.game_over?(@board).should == true
    end

  end

  describe '#next_player_turn' do
    before :each do
      @player_o.turn = 1
      @player_x.turn = 1
      @player_x.next_player_turn
    end
    it "changes current player's turn value to 0" do
      @player_x.turn.should == 0
    end

    it "changes opponent's turn value to 1" do
      @player_o.turn.should == 1
    end

  end

end
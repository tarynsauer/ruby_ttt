require 'spec_helper'

describe 'Game' do

  before :each do
    @board = Board.new()
    @game = Game.new('human', 'human', @board)
    @game.player_one.turn = 1
  end

  describe '#current_player' do
    it "returns player with a turn value of 1" do
      @game.current_player.should == @game.player_one
    end
  end

  describe '#clean_up_input' do
    it "returns cell ID in the correct format" do
      @game.clean_up_input('1a').should == '1A'
    end

    it "returns cell ID in the correct format" do
      @game.clean_up_input('a1').should == '1A'
    end
  end

  describe '#moves_remaining?' do
    it "returns false if board is full" do
      @board.filled_spaces = { '1A' => 'X', '2A' => 'O', '3A' => 'X',
                       '1B' => "O", '2B' => 'O', '3B' => 'X',
                       '1C' => 'X', '2C' => 'O', '3C' => 'X' }
      @game.moves_remaining?.should == false
    end

    it "returns true if board is not full" do
      @board.filled_spaces = { '1A' => 'X', '2A' => 'O', '3A' => 'X',
                       '1B' => "O", '2B' => 'O', '3B' => 'X',
                       '1C' => 'X', '2C' => 'O', '3C' => nil }
      @game.moves_remaining?.should == true
    end
  end

  describe '#winning_player?' do
    it "returns true if player gets three in a row" do
      @board.filled_spaces = { '1A' => 'X', '2A' => 'O', '3A' => 'X',
                       '1B' => "O", '2B' => 'X', '3B' => 'O',
                       '1C' => 'X', '2C' => 'O', '3C' => 'X' }
      @game.moves_remaining?.should == false
    end

    it "returns true if board is not full" do
      @board.filled_spaces = { '1A' => 'X', '2A' => 'O', '3A' => 'X',
                       '1B' => "O", '2B' => 'O', '3B' => 'X',
                       '1C' => 'X', '2C' => 'O', '3C' => nil }
      @game.moves_remaining?.should == true
    end
  end

  describe '#winning_move?' do
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
    ].each do |board_filled_spaces, expected_outcome|
      it "changes #{board_filled_spaces} into #{expected_outcome}" do
        @board.filled_spaces = board_filled_spaces
        @game.winning_move?('O').should == expected_outcome
      end
    end
  end

end